class SigninController < ApplicationController

  include SimpleCaptcha::ControllerHelpers

  before_filter :check_authentication, :except => [:login, :signout, :password_reset_get_login_account, :reset_password_request, :username_retrieval_get_login_account, :username_retrieval_request, :captcha]
  layout nil

  # Allows a user to log in.
  def login
    if request.post?
      begin
        login_account = LoginAccount.authenticate(params[:user_name], params[:password])
        session[:user] = login_account.id   # This will throw an exception if we do not have a valid login_account due to log in failing
        @group_types = LoginAccount.validate_group(session[:user])
        @system_permission_types = LoginAccount.validate_permission(session[:user])
        @access_attempts_count = LoginAccount.validate_attempts_count(session[:user])
        login_account.update_password = false
        login_account.update_attributes(:last_ip_address => request.remote_ip, :last_login => Time.now())
        session[:login_account_info] = login_account

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


        redirect_to welcome_url
      rescue
        # If we threw an exception for not logging
        #  in ok we will send a warning to the end user
        #flash.now[:warning] = flash_message(:type => "login_error")
        #rescue rescue_message = "your group do not have permissions"
        if login_account.nil?
          rescue_message = "Login Account is error"
        else if  @group_types.nil?
            rescue_message = "you do not have group"
          else if   @system_permission_types.nil?
              rescue_message = "group permission is error"
            else if @access_attempts_count.blank?
                rescue_message = "your account has been locked, please call admin"
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
    login_account.update_attributes(:last_logoff => Time.now()) unless login_account.nil?
    session[:user] = nil
    session[:current_list_id] = nil
    session[:current_person_id] = nil
    session[:login_account_info] = nil
    session[:super_admin] = nil
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

      email = LoginAccountPasswordResetDispatcher.create_email_notification(@login_account, password)
      LoginAccountPasswordResetDispatcher.deliver(email)

    else
      #invalid
      @login_account.access_attempts_count = (@login_account.access_attempts_count.nil? ? (3 - 1) : (@login_account.access_attempts_count - 1))
      @login_account.access_attempt_ip = request.remote_ip
      @login_account.login_status = false
      @login_account.save
      @password_reset = "false"

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

      email = LoginAccountUsernameRetrievalDispatcher.create_email_notification(@login_account)
      LoginAccountUsernameRetrievalDispatcher.deliver(email)

    else

      @login_account.access_attempts_count = (@login_account.access_attempts_count.nil? ? (3 - 1) : (@login_account.access_attempts_count - 1))
      @login_account.access_attempt_ip = request.remote_ip
      @login_account.login_status = false
      @login_account.save
      @username_retrieval = "false"

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

  private
  
  def login_as_user
  begin
        login_account = LoginAccount.authenticate(params[:user_name], params[:password])
        session[:user] = login_account.id   # This will throw an exception if we do not have a valid login_account due to log in failing
        @group_types = LoginAccount.validate_group(session[:user])
        @system_permission_types = LoginAccount.validate_permission(session[:user])
        @access_attempts_count = LoginAccount.validate_attempts_count(session[:user])
        login_account.update_password = false
        login_account.update_attributes(:last_ip_address => request.remote_ip, :last_login => Time.now())
        session[:login_account_info] = login_account

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


        redirect_to welcome_url
      rescue
        # If we threw an exception for not logging
        #  in ok we will send a warning to the end user
        #flash.now[:warning] = flash_message(:type => "login_error")
        #rescue rescue_message = "your group do not have permissions"
        if login_account.nil?
          rescue_message = "Login Account is error"
        else if  @group_types.nil?
            rescue_message = "you do not have group"
          else if   @system_permission_types.nil?
              rescue_message = "group permission is error"
            else if @access_attempts_count.blank?
                rescue_message = "your account has been locked, please call admin"
              end
            end
          end
        end

        flash.now[:warning] = rescue_message

      end
  end

  def login_as_super_admin
    if @client_setup.check_primary_password(params[:password])
      session[:super_admin] = true
      session[:user] = 0
      redirect_to welcome_url
    else
      session[:super_admin] = false
      flash.now[:warning] = "Login Account is error"
      render "login"
    end
  end
end
