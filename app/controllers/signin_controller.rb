class SigninController < ApplicationController

  # System logging added

  include SimpleCaptcha::ControllerHelpers

  before_filter :check_authentication, :except => [:login, :signout, :password_reset_get_login_account, :reset_password_request, :username_retrieval_get_login_account, :username_retrieval_request, :captcha, :grace_period_check, :ask_for_power_password, :login_as_super_user]

  layout nil

  # Allows a user to log in.
  def login
    if request.post?
      begin
        login_account = LoginAccount.authenticate(params[:user_name], params[:password])
        system_log("Login Account #{login_account.user_name} (ID #{login_account.id}) logged into the system.", @current_controller, @current_action, login_account)
        session[:last_event] = Time.now()
        if login_account.class.to_s == "SystemUser"          
          grace_period_check(login_account) if login_account.last_login.nil?
          password_lifetime_check(login_account)
          session[:user] = login_account.id   # This will throw an exception if we do not have a valid login_account due to log in failing
          @group_types = LoginAccount.validate_group(session[:user])
          @system_permission_types = LoginAccount.validate_permission(session[:user])
          @access_attempts_count = LoginAccount.validate_attempts_count(session[:user])
          login_account.update_password = false
          create_temp_list
          login_account.update_attributes(:last_ip_address => request.remote_ip, :last_login => Time.now())          
          session[:login_account_info] = login_account
          login_account.access_attempts_count = ClientSetup.first.number_of_login_attempts.blank? ? 5 : ClientSetup.first.number_of_login_attempts
          login_account.save
          redirect_to welcome_url
        else
          redirect_to :action => "ask_for_power_password", :user_name => params[:user_name]
        end
  
        
      rescue
        # If we threw an exception for not logging
        #  in ok we will send a warning to the end user
        #flash.now[:warning] = flash_message(:type => "login_error")
        #rescue rescue_message = "your group do not have permissions"
        system_log("There was a failed login attempt to the system from IP address #{request.remote_ip}", @current_controller, @current_action, nil)
        if login_account.nil?
          rescue_message = flash_message(:type => "login_error")
        else if  @group_types.nil?
            rescue_message = flash_message(:type => "login_group_error")
          else if   @system_permission_types.nil?
              rescue_message = flash_message(:type => "login_permission_error")
            else if @access_attempts_count.blank?
                rescue_message = flash_message(:type => "login_count_error")
              end
            end
          end
        end

        flash.now[:warning] = rescue_message

      end
    end
  end

  

  # Logs a user out.
  def signout
    login_account = LoginAccount.find_by_id(session[:user])
    @temp_list = TempList.find_by_login_account_id(session[:user])
    @temp_list.destroy unless @temp_list.nil?
    system_log("Login Account #{login_account.user_name} (ID #{login_account.id}) logged out of the system.", @current_controller, @current_action, login_account)
    login_account.update_attributes(:last_logoff => Time.now()) unless login_account.nil?
    session[:user] = nil
    session[:current_list_id] = nil
    session[:current_person_id] = nil
    session[:login_account_info] = nil
    session[:super_admin] = nil
    session[:last_event] = nil
    redirect_to login_url
  end

  def password_reset_get_login_account
    username = params[:password_reset_username]
    email_address = params[:password_reset_email_address]
    @login_account = LoginAccount.find(:first, :conditions => ["user_name = ? AND security_email = ?", username, email_address])
    @login_account = nil unless (!@login_account.nil? && simple_captcha_valid?) # We want to no proceeed if they got the captcha wrong
    respond_to do |format|
      format.js
    end
  end

  def reset_password_request
    username = params[:password_reset_username]
    email_address = params[:password_reset_email_address]
    @login_account = LoginAccount.find(:first, :conditions => ["user_name = ? AND security_email = ?", username, email_address])

    @password_reset = false

    answer_1 = params[:password_reset_answer_1]
    answer_2 = params[:password_reset_answer_2]
    answer_3 = params[:password_reset_answer_3]

    if (!@login_account.account_locked? && @login_account.question1_answer.to_s.downcase == answer_1.to_s.downcase && @login_account.question2_answer.to_s.downcase == answer_2.to_s.downcase && @login_account.question3_answer.to_s.downcase == answer_3.to_s.downcase )
      # valid
      @login_account.access_attempts_count = 3
      @login_account.access_attempt_ip = request.remote_ip
      @login_account.save
      @password_reset = "true"
      # Change the user's password, send out an email, update the view

      password = LoginAccount.generate_password
      @login_account.password = password
      # @login_account.password_by_admin = true
      @login_account.save

      # Send out the email


      system_log("Password reset email was sent for #{@login_account.user_name} (ID #{@login_account.id}).", @current_controller, @current_action, @login_account)
      email = LoginAccountPasswordResetDispatcher.create_email_notification(@login_account, password)
      LoginAccountPasswordResetDispatcher.deliver(email)

    else
      #invalid
      @login_account.access_attempts_count = (@login_account.access_attempts_count.nil? ? (3 - 1) : (@login_account.access_attempts_count - 1))
      @login_account.access_attempt_ip = request.remote_ip
      @login_account.login_status = false
      @login_account.save
      @password_reset = "false"
      system_log("There was an invalid password reset request for #{@login_account.user_name} (ID #{@login_account.id}).", @current_controller, @current_action, @login_account)
      # Update the view, either warn about 3 attempts or announce the account has been locked
    end

    respond_to do |format|
      format.js
    end

  end


  def username_retrieval_get_login_account
    email_address = params[:username_retrieval_email_address]
    @login_account = LoginAccount.find(:first, :conditions => ["security_email = ?", email_address])
    @login_account = nil unless (!@login_account.nil? && simple_captcha_valid?) # We want to no proceeed if they got the captcha wrong
    respond_to do |format|
      format.js
    end
  end


  def username_retrieval_request
    email_address = params[:username_retrieval_email_address]
    @login_account = LoginAccount.find(:first, :conditions => ["security_email = ?", email_address])

    @username_retrieval = false

    answer_1 = params[:username_retrieval_answer_1]
    answer_2 = params[:username_retrieval_answer_2]
    answer_3 = params[:username_retrieval_answer_3]

    if (!@login_account.account_locked? && @login_account.question1_answer.to_s.downcase == answer_1.to_s.downcase && @login_account.question2_answer.to_s.downcase == answer_2.to_s.downcase && @login_account.question3_answer.to_s.downcase == answer_3.to_s.downcase )

      @login_account.access_attempts_count = 3
      @login_account.access_attempt_ip = request.remote_ip
      @login_account.save
      @username_retrieval = "true"

      @login_account.save

      # Send out the email
      system_log("Username retrieval email sent for #{@login_account.user_name} (ID #{@login_account.id}).", @current_controller, @current_action, @login_account)
      email = LoginAccountUsernameRetrievalDispatcher.create_email_notification(@login_account)
      LoginAccountUsernameRetrievalDispatcher.deliver(email)

    else

      @login_account.access_attempts_count = (@login_account.access_attempts_count.nil? ? (3 - 1) : (@login_account.access_attempts_count - 1))
      @login_account.access_attempt_ip = request.remote_ip
      @login_account.login_status = false
      @login_account.save
      @username_retrieval = "false"
      system_log("There was an invalid username retrieval request for #{@login_account.user_name} (ID #{@login_account.id}).", @current_controller, @current_action, @login_account)
      # Update the view, either warn about 3 attempts or announce the account has been locked
    end

    respond_to do |format|
      format.js
    end

  end

  def captcha
    respond_to do |format|
      format.js
    end
  end

  def ask_for_power_password
    @user_name = params[:user_name]
    render "ask_for_power_password", :layout => "reset_password"
  end

  def login_as_super_user
    begin
      login_account = LoginAccount.authenticate_super_user(params[:user_name], params[:password])
      system_log("Super User account logged onto the system - #{login_account.user_name} (ID #{login_account.id}).", @current_controller, @current_action, login_account)
      session[:user] = login_account.id   # This will throw an exception if we do not have a valid login_account due to log in failing
      @group_types = LoginAccount.validate_group(session[:user])
      @system_permission_types = LoginAccount.validate_permission(session[:user])
      @access_attempts_count = LoginAccount.validate_attempts_count(session[:user])
      login_account.update_attributes(:last_ip_address => request.remote_ip, :last_login => Time.now())
      session[:login_account_info] = login_account
      login_account.access_attempts_count = ClientSetup.first.number_of_login_attempts.blank? ? 5 : ClientSetup.first.number_of_login_attempts
      login_account.save
      redirect_to welcome_url
    rescue
      system_log("Failed attempt to log in as a super user.", @current_controller, @current_action, nil)
      if login_account.nil?
        rescue_message = flash_message(:type => "login_error")
      else if  @group_types.nil?
          rescue_message = flash_message(:type => "login_group_error")
        else if   @system_permission_types.nil?
            rescue_message = flash_message(:type => "login_permission_error")
          else if @access_attempts_count.blank?
              rescue_message = flash_message(:type => "login_count_error")
            end
          end
        end
      end

      flash.now[:warning] = rescue_message
      render "login"
    end
  end

  private
  
  def create_temp_list
    #clear temp list data
    @temp_list = TempList.find_by_login_account_id(session[:user])
    @temp_list.destroy unless @temp_list.nil?
    #create a temp list for all people on the lists(group lists and user lists)
    @temp_list = TempList.new(:name => "List of all people", :list_size => 0, :last_date_generated => Date.today(), :status => true, :source => "Temp List", :source_type => "T", :allow_duplication => false, :login_account_id => session[:user])
    @temp_list.save
    temp_list_id = @temp_list.id
    person_ids = Array.new

    #people on group list
    LoginAccount.find(session[:user]).list_headers.each do |i|
      @list_header = ListHeader.find(i)
      @list_details = @list_header.list_details
      @list_details.each do |list_detail|
        person_ids << list_detail.person_id unless person_ids.include?(list_detail.person_id)
      end
    end

    #people on user list
    LoginAccount.find(session[:user]).user_lists.each do |i|
      @list_header = ListHeader.find(i.list_header_id)
      @list_details = @list_header.list_details
      @list_details.each do |list_detail|
        person_ids << list_detail.person_id unless person_ids.include?(list_detail.person_id)
      end
    end

    person_ids.each do |i|
      @list_detail = ListDetail.new(:list_header_id => temp_list_id, :person_id => i)
      @list_detail.save
    end
  end


  def grace_period_check(login_account)
    if ( !login_account.authentication_grace_period.nil? && login_account.authentication_grace_period.to_i > 0)
      # If we have no timeout or if timeout is not defined or if we have not had a last event record
     
      if( ( (Time.now - login_account.created_at) / (24 * 60 * 60) ) > login_account.authentication_grace_period )
        # We are outside the grace period, delete the account
        system_log("Login Account #{login_account.user_name} (ID #{login_account.id}) attempted to login outside of the defined grace period.", @current_controller, @current_action, login_account)
        login_account.destroy
        flash[:warning] = flash_message(:type => "grace_period_expired")
        session[:user] = nil
        render "login"
      else
        # Let's assume there is no grace period set
        return # do nothing
      end

    end

  end

  def password_lifetime_check(login_account)
    if( ( ( (!login_account.password_lifetime.nil? && login_account.password_lifetime.to_i > 0) && (Time.now - login_account.password_updated_at) / (24 * 60 * 60) ) > login_account.password_lifetime.to_i) )
      system_log("Password expired for #{login_account.user_name} (ID #{login_account.id}).", @current_controller, @current_action, login_account)
      redirect_to :controller => "login_accounts", :action => "change_password"
    end
  end

end
