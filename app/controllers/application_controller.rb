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
  before_filter :instantiate_controller_and_action_names, :check_authentication

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end

  def check_authentication
    unless session[:user]
      session[:intended_action] = action_name
      session[:intended_controller] = controller_name
      redirect_to login_url
    else
      @current_user = LoginAccount.find(session[:user])
    end
  end


  def flash_message(options = {})

    options[:type] ||= "default"
    options[:object] ||= ""
    options[:field] ||= ""
    options[:message] ||= ""

    result = case options[:type]

    # Success
    when "object_created_successfully" then "A new #{options[:object]} was created."
    when "object_updated_successfully" then "The #{options[:object]} was updated."

    # Errors
    when "login_error" then "The login credentials you supplied were incorrect."
    when "field_missing" then "You did not fill out the required field #{options[:field]}."
    when "uniqueness_error" then "#{options[:field]} has already existed."
    when "not exist" then "#{options[:field]} not exist in system"
    when "too long" then "#{options[:field]} is too long"
    when "too short" then "#{options[:field]} is too short"

    # Default
    when default then ""
    end

    options[:message] ?  result : result + " #{options[:message]}"
  end

end
