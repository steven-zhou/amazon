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
    puts"******DEBUG****DFDFDSFDF**"
     render :layouts => 'reset_password'
  end
end
