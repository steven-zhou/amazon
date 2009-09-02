class SigninController < ApplicationController

  before_filter :check_authentication, :except => [:login, :signout]
  layout nil

  # Allows a user to log in.
  def login

    if request.post?
      begin
        session[:user] = LoginAccount.authenticate(params[:user_name], params[:password]).id
        if (session[:intended_action] != nil && session[:intended_controller] != nil)
          redirect_to :action => session[:intended_action],  :controller => session[:intended_controller]
        else
          redirect_to welcome_url
        end
      rescue
        flash.now[:warning] = "Username or password invalid."
      end
    end
  end
  
  # Logs a user out.
  def signout
    session[:user] = nil
    redirect_to login_url
  end


end
