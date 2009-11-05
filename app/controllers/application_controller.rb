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
    @show_list = session[:show_list]

  end

  def check_authentication
    unless session[:super_admin]
      unless session[:user]
        redirect_to login_url
      else
        @current_user = LoginAccount.find(session[:user])
        redirect_to :controller => "dashboards", :action => "check_password" if (@current_user.password_by_admin && @current_controller != "dashboards" && @current_action != "check_password" && (@current_controller != "dashboards" && @current_action != "update_password"))
      end
    end
  end

  def system_log(message, current_controller=@current_controller, current_action=@current_action)
    system_log = SystemLog.new(:message => message, :user_id => @current_user.id, :controller => current_controller, :action => current_action, :ip_address => request.remote_ip)
    system_log.save
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
    when "login_group_error" then "Your login account is not associated with any groups. Please see your System Administrator."
    when "login_permission_error" then "You do not have the appropriate level of permissions to log into the system. Please see your System Administrator."
    when "login_count_error" then "Your account has been locked. Please see your System Administrator."
    when "field_missing" then "You did not fill out the required field #{options[:field]}."
    when "uniqueness_error" then "The value you entered for #{options[:field]} already exists. Please ensure this value is unique and try again."
    when "not exist" then "The value you entered for #{options[:field]} does not exist in system"
    when "too_long" then "The value you entered for #{options[:field]} is too long."
    when "too_short" then "The value you entered for #{options[:field]} is too short."
    when "format error" then "The format of #{options[:field]} is incorrect."
    when "same_person_error" then "#{options[:field]} cannot be the same as the source person."
      # Default
    when "default" then " #{options[:message]}"
    end

    options[:message] ?  result : result + " #{options[:message]}"
  end



end
