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
         #session[:user_list] = UserList.find_by_user_id(session[:user])
         #puts"DEBUG-SESSION--#{session[:user_list].to_yaml}"
         session[:login_account_info] = LoginAccount.find_by_id(session[:user])

        if (session[:intended_action] != nil && session[:intended_controller] != nil)
          redirect_to :action => session[:intended_action],  :controller => session[:intended_controller]
        else
          redirect_to welcome_url
        end
      rescue
        # If we threw an exception for not loggin in ok we will send a warning to the end user
        flash.now[:warning] = flash_message(:type => "login_error")
      end
    end
  end
  
  # Logs a user out.
  def signout
    login_account = LoginAccount.find_by_id(session[:user])
    login_account.update_attributes(:last_logoff => Time.now()) unless login_account.nil?
    session[:user] = nil
    redirect_to login_url
  end


end
