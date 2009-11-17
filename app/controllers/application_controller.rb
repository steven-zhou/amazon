# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  # System loggin added
 
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
    unless session[:user]
      redirect_to login_url
    else
      @current_user = LoginAccount.find(session[:user])
      check_session_timeout(@current_user)
      redirect_to :controller => "dashboards", :action => "check_password" if (@current_user.password_by_admin && @current_controller != "dashboards" && @current_action != "check_password" && (@current_controller != "dashboards" && @current_action != "update_password"))
      session[:last_event] = Time.now()
    end
  end

  def flash_message(options = {})

    options[:type] ||= "default"
    options[:object] ||= ""
    options[:field] ||= ""
    options[:message] ||= ""

    result = case options[:type]

      # Success
    when "object_created_successfully"      then "The New #{options[:object]} is Created."
    when "object_updated_successfully"      then "The #{options[:object]} is Updated Successfully."

      # Errors
    when "login_online_error"               then "You can not login: Another Person Is Online "
    when "login_error"                      then "One or More of the Sign In Details is Invalid,Please Try Again."
    when "login_group_error"                then "Your User Account Has No Security Group, Please Contact System Administrator."

    when "login_permission_error"           then "Your User Account Has No Access Permissions, Please Contact System Administrator"
    when "session_timeout"                  then "For Security Reasons, The Grace Period to Activate Your Account has expired, Please Contact System Administrator"
    when "grace_period_expired"             then "You have attempted to login after the grace period for your account. Your account has been deleted. Please see your Systems Administrator."
    when "account_inactive"                 then "Your account is currently inactive. Please see your System Administrator."
    when "login_count_error"                then "For Security Reasons, Your Account has been Locked, Please Contact System Administrator"
    when "login_invalid_account_type"       then "Your login account is not of a valid account type to proceed."
    when "supplied_info_incorrect"          then "Invalid Details Entered, Please Try Again"
    when "password_confirm_error"           then "Passwords DO NOT Match"
    when "new_password_equals_old_password" then " New Password Can not be The Same as Old Password, Please Try Again"
    when "set_password_error"               then "Invalid Password Entered, Please try again."
    when "password_change_ok"               then "Password is Changed Successfully"
    when "field_missing"                    then "Missing Required Data, #{options[:field]}."
    when "uniqueness_error"                 then "The #{options[:field]} Already Exists. This Field Must be Unique, Please Try Again."
    when "not exist"                        then "The #{options[:field]} Does Not Exist, Please Try Again"
    when "too_long"                         then "The #{options[:field]} is Too Long, Please try Again"
    when "too_short"                        then "The #{options[:field]} is Too Short, Please try Again"
    when "format error"                     then "Invalid Format for #{options[:field]}, Please Try Again."
    when "same_person_error"                then "#{options[:field]} Cannot be the Same as the Source Person."
      # Default
    when "default" then " #{options[:message]}"
    end

    options[:message] ?  result : result + " #{options[:message]}"
  end


  private

  def check_session_timeout(current_user)
    if ( !session[:last_event].nil? && session[:last_event].to_i != 0 && !current_user.session_timeout.nil? && current_user.session_timeout.to_i > 0)
      # If we have no timeout or if timeout is not defined or if we have not had a last event record

      if ( (current_user.session_timeout.to_i * 60 ) < (Time.now - session[:last_event]))
        system_log = SystemLog.new(:message => "Login Account #{current_user.user_name} (ID #{current_user.id}) session timed out.", :controller => @current_controller, :action => @current_action, :login_account_id => current_user.id, :ip_address => request.remote_ip)
        system_log.save
        # The session has timed out, set a message, boot them out....
        session[:user] = nil
        session[:last_event] = nil
        current_user.update_attribute(:online_status, false)
        flash[:warning] = flash_message(:type => "session_timeout")
        redirect_to login_url
      else
        # We have not timed out...
        session[:last_event] = Time.now()
      end

    else
      # Let's assume there is no timeout set
      session[:last_event] = Time.now()
      return # do nothing
    end

  end

 
  def system_log(message, current_controller=@current_controller, current_action=@current_action, login_account=@current_user)
    system_log = SystemLog.new(:message => message, :controller => current_controller, :action => current_action, :ip_address => request.remote_ip)
    system_log.login_account_id = login_account.nil? ? nil : login_account.id
    system_log.save
    puts "#{system_log.to_yaml}"
  end

end
