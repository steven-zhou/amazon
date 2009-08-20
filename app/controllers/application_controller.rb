# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include ExceptionNotifiable

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'ed1b9f08c2bca568088ef5068a3decb7'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  before_filter :instantiate_controller_and_action_names

  def instantiate_controller_and_action_names
      @current_action = action_name
      @current_controller = controller_name
  end

  def check_authentication
    unless session[:user]
      redirect_to login_url
    else
      @current_user = LoginAccount.find(session[:user])
    end
  end


end
