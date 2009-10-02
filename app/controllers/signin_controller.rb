class SigninController < ApplicationController

  before_filter :check_authentication, :except => [:login, :signout]
  layout nil

  # Allows a user to log in.
  def login



    if request.post?
      begin
        login_account = LoginAccount.authenticate(params[:user_name], params[:password])
        session[:user] = login_account.id   # This will throw an exception if we do not have a valid login_account due to log in failing
        login_account.update_attributes(:last_ip_address => request.remote_ip, :last_login => Time.now())

        session[:login_account_info] = login_account
       
        @group_types = LoginAccount.validate_group(session[:user])
        @system_permission_types = LoginAccount.validate_permission(session[:user])
        

        if (session[:intended_action] != nil && session[:intended_controller] != nil)
          #puts "***** DEBUG Redirecting to the intended action and controller"
          redirect_to :action => session[:intended_action],  :controller => session[:intended_controller]
        else
          #puts "***** DEBUG going to welcome_url"
          redirect_to welcome_url
        end
      rescue
        # If we threw an exception for not logging
        #  in ok we will send a warning to the end user
        #puts "**** DEBUG Rescued!"
        flash.now[:warning] = flash_message(:type => "login_error")
      end
    end
  end
  
  # Logs a user out.
  def signout
    login_account = LoginAccount.find_by_id(session[:user])
    login_account.update_attributes(:last_logoff => Time.now()) unless login_account.nil?
    session[:user] = nil
    session[:current_list_id] = nil
    session[:current_person_id] = nil
    session[:login_account_info] = nil
    redirect_to login_url
  end


end
