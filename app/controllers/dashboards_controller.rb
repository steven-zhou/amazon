class DashboardsController < ApplicationController
  # System logging completed....
  # Optimized
  
  def index
    @column1 = DashboardPreference.user_column(session[:user], 1)
    @column2 = DashboardPreference.user_column(session[:user], 2)
    @column3 = DashboardPreference.user_column(session[:user], 3)
    @superadmin_message = ClientSetup.first.superadmin_message
    @system_news = SystemNews.new
    @current_news = SystemNews.first_three
    @to_do_list = ToDoList.new
    @to_do_lists = @current_user.to_do_lists
    if @current_user.class.to_s == "SystemUser"
      @current_user.update_password = false
      @current_user.access_attempts_count = ClientSetup.first.number_of_login_attempts.blank? ? 99999 : ClientSetup.first.number_of_login_attempts
    else
      @current_user.access_attempts_count = 99999
    end
    @current_user.online_status = true
    @current_user.save
    @super_admin = (@current_user.class.to_s == "SuperAdmin" || @current_user.class.to_s == "MemberZone") ? true : false
    @new_to_do = ToDoList.new_to_do(session[:user])
    @processing_to_do = ToDoList.processing_to_do(session[:user])
    @completed_to_do = ToDoList.completed_to_do(session[:user])
    puts " Session[current org list id] is #{session[:current_org_list_id]} ************00000000"
    respond_to do |format|
      format.html
    end
  end


  def check_password
    @login_account = @current_user
    render :layout => 'reset_password'
  end

  def update_password
    @login_account = LoginAccount.find(params[:id].to_i)
    begin
      LoginAccount.authenticate(@current_user.user_name, params[:old_password])
      @login_account.update_password = true
      if @login_account.update_attributes(params[:login_account])
        flash[:message] = " Saved successfully"
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated their password.")
        redirect_to login_url
      else
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update their password .")
        flash[:error] = flash_message(:type => "field_missing", :field => "password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("can't be blank"))
        flash[:error] = flash_message(:type => "format error", :field => "password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("regular expression of password is wrong."))
        flash[:error] = flash_message(:type => "field_missing", :field => "repeat_password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?( "password confirmation is different with password"))
        flash[:error] = flash_message(:type => "too_short", :field => "password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("pick a longer name"))
        flash[:error] = flash_message(:type => "too_long", :field => "password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("pick a shorter name"))
        flash[:error] = flash_message(:type => "field_missing", :field => "question1_answer")if(!@login_account.errors[:question1_answer].nil? && @login_account.errors.on(:question1_answer).include?("you must type three security questions answer."))
        flash[:error] = flash_message(:type => "field_missing", :field => "question2_answer")if(!@login_account.errors[:question2_answer].nil? && @login_account.errors.on(:question2_answer).include?("you must type three security questions answer."))
        flash[:error] = flash_message(:type => "field_missing", :field => "question3_answer")if(!@login_account.errors[:question3_answer].nil? && @login_account.errors.on(:question3_answer).include?("you must type three security questions answer."))
        redirect_to :action => "check_password"
      end
    rescue
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) entered an incorrect password when attempting to update their password.")
      redirect_to  login_url
      flash[:error] = "Invalid Password Entered, You Have only #{@current_user.access_attempts_count - 1} Attempts Left"
      @current_user.update_password = false if @current_user.class.to_s == "SystemUser"
      @current_user.access_attempts_count -= 1
      @current_user.online_status = false
      @current_user.save
    end
  end

  def save_dashboard
    @dashboard_preferences = @current_user.to_do_lists
    @dashboard_preferences.each do |i|
      i.destroy
    end
    boxes1 = params[:column1].split(",")
    boxes2 = params[:column2].split(",")
    boxes3 = params[:column3].split(",")
    save_boxes(1, boxes1)
    save_boxes(2, boxes2)
    save_boxes(3, boxes3)

    respond_to do |format|
      format.js
    end
  end

  def save_boxes(column, boxes)
    boxes.each do |i|
      @dashboard_preferences = DashboardPreference.new(:login_account_id => session[:user], :column_id => column, :box_id => i)
      @dashboard_preferences.save
    end
  end
end
