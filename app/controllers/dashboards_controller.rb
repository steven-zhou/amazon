class DashboardsController < ApplicationController
  # System logging completed....

  def index
    @column1 = DashboardPreference.find(:all, :conditions => ["login_account_id = ? and column_id = ?", session[:user], "1"], :order => "id")
    @column2 = DashboardPreference.find(:all, :conditions => ["login_account_id = ? and column_id = ?", session[:user], "2"], :order => "id")
    @column3 = DashboardPreference.find(:all, :conditions => ["login_account_id = ? and column_id = ?", session[:user], "3"], :order => "id")
    @superadmin_message = ClientSetup.first.superadmin_message
    @system_news = SystemNews.new
    @current_news = SystemNews.first_three
    @to_do_list = ToDoList.new
    @to_do_lists = ToDoList.find_all_by_login_account_id(session[:user])
    @current_user = LoginAccount.find(session[:user])
    @super_admin = (@current_user.class.to_s == "SuperAdmin" || @current_user.class.to_s == "MemberZone") ? true : false
     @new_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "new", session[:user]], :order => "created_at")
    @processing_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "processing", session[:user]], :order => "created_at")
    @completed_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "completed", session[:user]], :order => "created_at")
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
      flash[:error] = "your old password is wrong!!, you have only #{@current_user.access_attempts_count - 1} choice"
      @current_user.update_password = false if @current_user.class.to_s == "SystemUser"
      @current_user.access_attempts_count -= 1
      @current_user.save
    end
  end

  def save_dashboard
    @dashboard_preferences = DashboardPreference.find(:all, :conditions => ["login_account_id = ?", session[:user]])
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
