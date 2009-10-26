class ToDoListsController < ApplicationController

  def create
    @to_do_list = ToDoList.new(params[:to_do_list])
    @to_do_list.login_account_id = session[:user]
    @to_do_list.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @to_do_list = ToDoList.find(params[:id].to_i)
    @to_do_list.destroy
    respond_to do |format|
      format.js
    end
  end
end
