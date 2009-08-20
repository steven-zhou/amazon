class SigninController < ApplicationController

  before_filter :check_authentication, :except => [:login, :signout]
  layout nil

  # Allows a user to log in.
  def login

    if request.post?

      begin
        session[:user] = LoginAccount.authenticate(params[:user_name], params[:password]).id
        redirect_to welcome_url
      rescue
        flash[:warning] = "Username or password invalid."
      end
    end
  end

  # Logs a user out.
  def signout
    session[:user] = nil
    redirect_to login_url
  end


end
