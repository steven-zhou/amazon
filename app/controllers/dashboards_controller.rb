class DashboardsController < ApplicationController

  def index
    @system_news = SystemNews.new
    @to_do_list = ToDoList.new
    @to_do_lists = ToDoList.find_all_by_login_account_id(session[:user])
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
        
        redirect_to login_url
      else
       
        flash[:error] = flash_message(:type => "field_missing", :field => "password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("can't be blank"))
        flash[:error] = flash_message(:type => "format error", :field => "password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("regular expression of password is wrong."))
        flash[:error] = flash_message(:type => "field_missing", :field => "repeat_password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?( "password confirmation is different with password"))
        flash[:error] = flash_message(:type => "too_short_name", :field => "password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("pick a longer name"))
        flash[:error] = flash_message(:type => "too_long_name", :field => "password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("pick a shorter name"))
        flash[:error] = flash_message(:type => "field_missing", :field => "question1_answer")if(!@login_account.errors[:question1_answer].nil? && @login_account.errors.on(:question1_answer).include?("you must type three security questions answer."))
        flash[:error] = flash_message(:type => "field_missing", :field => "question2_answer")if(!@login_account.errors[:question2_answer].nil? && @login_account.errors.on(:question2_answer).include?("you must type three security questions answer."))
        flash[:error] = flash_message(:type => "field_missing", :field => "question3_answer")if(!@login_account.errors[:question3_answer].nil? && @login_account.errors.on(:question3_answer).include?("you must type three security questions answer."))
        redirect_to :action => "check_password"
      end
    rescue
      redirect_to  login_url
       flash[:error] = "your old password is wrong!!, you have only #{@current_user.access_attempts_count - 1} choice"
       @current_user.update_password = false
      @current_user.access_attempts_count -= 1
      @current_user.save
    end
  end
end
