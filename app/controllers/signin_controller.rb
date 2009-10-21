class SigninController < ApplicationController

  before_filter :check_authentication, :except => [:login, :signout]
  layout nil

  # Allows a user to log in.
  def login



    if request.post?
      begin
        login_account = LoginAccount.authenticate(params[:user_name], params[:password])
        session[:user] = login_account.id   # This will throw an exception if we do not have a valid login_account due to log in failing
   
       
        @group_types = LoginAccount.validate_group(session[:user])
        @system_permission_types = LoginAccount.validate_permission(session[:user])
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
        #flash.now[:warning] = flash_message(:type => "login_error")
        #rescue rescue_message = "your group do not have permissions"
        if login_account.nil?
          rescue_message = "Login Account is error"
        else if  @group_types.nil?
            rescue_message = "you do not have group"
          else if   @system_permission_types.nil?
              rescue_message = "group permission is error"
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
    
    redirect_to login_url
  end


end
