class SigninController < ApplicationController

  # System logging added
  # optimized

  include SimpleCaptcha::ControllerHelpers

  before_filter :check_authentication, :except => [:login, :signout, :password_reset_get_login_account, :reset_password_request, :username_retrieval_get_login_account, :username_retrieval_request, :captcha, :grace_period_check, :ask_for_power_password, :login_as_super_user]

  layout nil

  # Allows a user to log in.
  def login
    if request.post?
      begin
        # Step 1 - Check the username and password supplied
        # IF the username and password is wrong, we will throw an exception and be sent down to the rescue
        LoginAccount.current_user = LoginAccount.find(1)
        login_account = LoginAccount.authenticate(params[:user_name], params[:password])  
        # Check to see if the account is new and if so, are the still within their grace period
        # If not, delete the account        
        begin
          redirect_to :action => "ask_for_power_password", :user_name => params[:user_name], :clocktime => params[:clocktime], :clocktime_date => params[:clocktime_date] and return unless login_account.class.to_s == "SystemUser"
          account_system_user_check(login_account) # Checks the system_user attribute
          grace_period_check(login_account) if login_account.last_login.nil? # Check if a user logs in for the first time before the grace period expires
          account_active_check(login_account) # Check that the login_status attribute is true
          account_locked_check(login_account) # Check that there are remaining access_attempts_count available
          check_groups(login_account) # Check that user belongs to at least one group
          check_group_permissions(login_account) # Check the permissions for the groups of the login account
          check_online_status(login_account) #check the account has already online or not, if true, you can not login.
          check_password_life_time(login_account)# Check if the password has expired  when expired jump to rescue no.1 case
          check_number_of_online_users(login_account)# Check if the user number out of license number
 
          #---------------------------------------------successful login-------------------------#
          session[:user] = login_account.id
          session[:last_event] = Time.now()
          login_account.update_password = false
          create_temp_list
          login_account.update_attributes(:last_ip_address => request.remote_ip, :last_login => Time.now())
          #login_account.access_attempts_count = ClientSetup.first.number_of_login_attempts.blank? ? 5 : ClientSetup.first.number_of_login_attempts
          login_account.online_status = true
          login_account.save
          system_log("Login Account #{login_account.user_name} (ID #{login_account.id}) logged into the system.", "signin", "login", login_account)
          session[:clocktime]= params[:clocktime]
          session[:clocktime_date]= params[:clocktime_date]
          redirect_to welcome_url

          #---------------------------------------------exception erea-------------------------#
        rescue Exception => exc
          case exc.message
          when "Password Lifetime Check Failed"
            session[:user] = login_account.id
            session[:last_event] = Time.now()
            login_account.update_attributes(:last_ip_address => request.remote_ip, :last_login => Time.now())          
            redirect_to :controller => "login_accounts", :action => "change_password" and return
          else
            redirect_to :action => "login"
          end         
        end
      rescue
        system_log("There was a failed login attempt to the system from IP address #{request.remote_ip} supplying username #{params[:user_name]}.", "signin", "login", nil)
        login_account = LoginAccount.find_by_user_name(params[:user_name])
        invalid_access_attempt(login_account) unless login_account.nil?
        flash.now[:warning] = flash_message(:type => "login_error")
        render "login"
      end

    end
  end


  # Logs a user out.
  def signout
    login_account = LoginAccount.find_by_id(session[:user])

    LoginAccount.current_user = login_account
    @current_user = login_account
    @temp_list = TempList.find_by_login_account_id(session[:user])
    @temp_list.destroy unless @temp_list.nil?
    system_log("Login Account #{login_account.user_name} (ID #{login_account.id}) logged out of the system.", "signin", "signout")
    login_account.update_attributes(:last_logoff => Time.now(), :online_status => false ) unless login_account.nil?
    session[:user] = nil
    session[:current_list_id] = nil
    session[:current_person_id] = nil
    session[:last_event] = nil
    session[:current_organisation_id] = nil
    session[:current_org_list_id] = nil
    redirect_to login_url
  end

  def password_reset_get_login_account
    username = params[:password_reset_username]
    email_address = params[:password_reset_email_address]
    @login_account = LoginAccount.find(:first, :conditions => ["user_name = ? AND security_email = ?", username, email_address])
    @login_account = nil if (!simple_captcha_valid?) # We want to no proceeed if they got the captcha wrong
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


      system_log("Password reset email was sent for #{@login_account.user_name} (ID #{@login_account.id}).", "signin", "reset_password_request", @login_account)
      email = LoginAccountPasswordResetDispatcher.create_email_notification(@login_account, password)
      LoginAccountPasswordResetDispatcher.deliver(email)

    else
      #invalid
      @login_account.access_attempts_count = (@login_account.access_attempts_count.nil? ? (3 - 1) : (@login_account.access_attempts_count - 1))
      @login_account.access_attempt_ip = request.remote_ip
      @login_account.login_status = false
      @login_account.save
      @password_reset = "false"
      system_log("There was an invalid password reset request for #{@login_account.user_name} (ID #{@login_account.id}).", "signin", "reset_password_request", @login_account)
      # Update the view, either warn about 3 attempts or announce the account has been locked
    end

    respond_to do |format|
      format.js
    end

  end


  def username_retrieval_get_login_account
    email_address = params[:username_retrieval_email_address]

    @login_account = LoginAccount.find(:first, :conditions => ["security_email = ?", email_address])
    @login_account = nil if (!simple_captcha_valid?) # We want to not proceeed if they got the captcha wrong

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
      system_log("Username retrieval email sent for #{@login_account.user_name} (ID #{@login_account.id}).", "signin", "username_retrieval_request", @login_account)
      email = LoginAccountUsernameRetrievalDispatcher.create_email_notification(@login_account)
      LoginAccountUsernameRetrievalDispatcher.deliver(email)

    else

      @login_account.access_attempts_count = (@login_account.access_attempts_count.nil? ? (3 - 1) : (@login_account.access_attempts_count - 1))
      @login_account.access_attempt_ip = request.remote_ip
      @login_account.login_status = false
      @login_account.save
      @username_retrieval = "false"
      system_log("There was an invalid username retrieval request for #{@login_account.user_name} (ID #{@login_account.id}).", "signin", "username_retrieval_request", @login_account)
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
    @clock = params[:clocktime]
    @clock_date = params[:clocktime_date]
    render "ask_for_power_password", :layout => "reset_password"
  end

  def login_as_super_user
    begin
      LoginAccount.current_user = LoginAccount.find(1)
      login_account = LoginAccount.authenticate_super_user(params[:user_name], params[:password])
      #system_log("Super User account logged onto the system - #{login_account.user_name} (ID #{login_account.id}).", "signin", "login_as_super_user", login_account)
      begin
        
        if login_account.class.to_s == "SuperAdmin"
          check_online_status(login_account) #check the account has already online or not, if true, you can not login.
          check_number_of_online_users(login_account)# Check if the user number out of license number
        end

        #---------------------------------------------successful login-------------------------#
        session[:user] = login_account.id
        session[:last_event] = Time.now()
        login_account.update_attributes(:last_ip_address => request.remote_ip, :last_login => Time.now())
        login_account.online_status = true
        login_account.access_attempts_count = 99999
        login_account.save
        system_log("Login Account #{login_account.user_name} (ID #{login_account.id}) logged into the system.", "signin", "login", login_account)
        session[:clocktime]= params[:clocktime]
        session[:clocktime_date]= params[:clocktime_date]
        redirect_to welcome_url
        #---------------------------------------------exception erea-------------------------#
      rescue Exception => exc
        case exc.message
        when "Password Lifetime Check Failed"
          session[:user] = login_account.id
          session[:last_event] = Time.now()
          login_account.update_attributes(:last_ip_address => request.remote_ip, :last_login => Time.now())

          redirect_to :controller => "login_accounts", :action => "change_password" and return
        else
          redirect_to :action => "login"
        end
      end
    rescue
      system_log("There was a failed login attempt to the system from IP address #{request.remote_ip} supplying username #{params[:user_name]}.", "signin", "login", nil)
      login_account = LoginAccount.find_by_user_name(params[:user_name])
      invalid_access_attempt(login_account) unless login_account.nil?
      flash.now[:warning] = flash_message(:type => "login_error")
      render "login"
    end
  end



  
  private

  def grace_period_check(login_account)
    if ( !login_account.authentication_grace_period.nil? && login_account.authentication_grace_period.to_i > 0)
      # If we have no timeout or if timeout is not defined or if we have not had a last event record
      if( ( (Time.now - login_account.created_at.getlocal) / (24 * 60 * 60) ) > login_account.authentication_grace_period.to_i )
        # If time since the account was created (in days) is greater than the grace period allowed
        # delete the account
        system_log("Login Account #{login_account.user_name} (ID #{login_account.id}) attempted to login outside of the defined grace period.", "signin", "grace_period_check", login_account)
        # login_account.destroy
        flash[:warning] = flash_message(:type => "grace_period_expired")
        raise "Grace Period Check Failed"
      else
        # Let's assume there is no grace period set
        return # do nothing
      end

    end

  end



  # If we have had an invalid access attempt, record their i[ and decrease number of access attempts availabnle
  def invalid_access_attempt(login_account)
    login_account.access_attempts_count -= 1 if login_account.access_attempts_count.to_i > 0
    login_account.access_attempt_ip = request.remote_ip
    login_account.save
  end

  # Check if the user's account is active
  def account_active_check(login_account)
    unless login_account.account_active?
      flash[:warning] = flash_message(:type => "account_inactive")
      raise "Account Active Check Failed"
    end
  end

  # Check if the user's account is locked
  def account_locked_check(login_account)
    if login_account.account_locked?
      flash[:warning] = flash_message(:type => "login_count_error")
      raise "Account Locked Check Failed"
    end
  end

  def account_system_user_check(login_account)
    unless login_account.system_user?
      flash[:warning] = flash_message(:type => "login_invalid_account_type")
      raise "Account System User Check Failed"
    end
  end

  def check_groups(login_account)
    unless login_account.has_groups?
      flash[:warning] = flash_message(:type => "login_group_error")
      raise "Group Check Failed"
    end

  end


  def check_group_permissions(login_account)
    unless login_account.has_group_permissions?
      flash[:warning] = flash_message(:type => "login_permission_error")
      raise "Group Permission Check Failed"
    end
  end



  def check_online_status(login_account)
    if login_account.online_status?
      flash[:warning] = flash_message(:type => "login_online_error")
      raise "Online Status Check Failed"
    end
  end


  def check_number_of_online_users(login_account)
    number_of_users =  ClientSetup.first.number_of_users.blank? ? 5 : ClientSetup.first.number_of_users
    if login_account.number_of_online_users >= number_of_users
      flash[:warning] = flash_message(:type => "login_online_max_error")
      raise "Online User Number Check Failed"
    end
  end

  # Check if their password needs to be changed
  def check_password_life_time(login_account)
    if login_account.password_expired?
      system_log("Password expired for #{login_account.user_name} (ID #{login_account.id}).", "signin", "password_lifetime_check", login_account)
      raise "Password Lifetime Check Failed"
    end
  end

  def create_temp_list
    #clear temp list data
    @temp_list = TempList.find_by_login_account_id(session[:user])
    @temp_list.destroy unless @temp_list.nil?
    current_user = LoginAccount.find(session[:user])
    #create a temp list for all people on the lists(group lists and user lists)
    @temp_list = TempList.new(:name => "List of all people for #{current_user.user_name}", :list_size => 0, :last_date_generated => Date.today(), :status => true, :source => "Temp List", :source_type => "T", :allow_duplication => false, :login_account_id => session[:user])
    @temp_list.save
    temp_list_id = @temp_list.id
    person_ids = Array.new

    #people on group list

    current_user.all_person_lists.each do |i|
      @list_header = ListHeader.find(i)
      @list_details = @list_header.list_details
      @list_details.each do |list_detail|
        person_ids << list_detail.entity_id unless person_ids.include?(list_detail.entity_id)
      end
    end

    person_ids.each do |i|
      @list_detail = ListDetail.new(:list_header_id => temp_list_id, :entity_id => i)
      @list_detail.save
    end
  end

end
