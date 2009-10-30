class DashboardsController < ApplicationController

  def index
    @system_news = SystemNews.new
    @super_admin = (session[:super_admin]==true) ? true : false
    puts "**********************#{@super_admin}*****************"
    @to_do_list = ToDoList.new
    @to_do_lists = ToDoList.find_all_by_login_account_id(session[:user])
    respond_to do |format|
      format.html
    end
  end
end
