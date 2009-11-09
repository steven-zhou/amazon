class ToDoListsController < ApplicationController

  def index
    @new_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "new", session[:user]], :order => "created_at")
    @processing_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "processing", session[:user]], :order => "created_at")
    @completed_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "completed", session[:user]], :order => "created_at")
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @to_do_list = ToDoList.new(params[:to_do_list])
    @to_do_list.login_account_id = session[:user]
    @to_do_list.status = "new"
    unless @to_do_list.save
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "description") if (!@to_do_list.errors[:description].nil? && @to_do_list.errors.on(:description) == "has already been taken")
      flash.now[:error] = flash_message(:type => "field_missing", :field => "description") if (!@to_do_list.errors[:description].nil? && @to_do_list.errors.on(:description) == "can't be blank")
    end
    @new_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "new", session[:user]], :order => "created_at")
    @processing_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "processing", session[:user]], :order => "created_at")
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @to_do_list = ToDoList.find(params[:id].to_i)
    @to_do_list.destroy
    @new_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "new", session[:user]], :order => "created_at")
    @processing_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "processing", session[:user]], :order => "created_at")
    @completed_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "completed", session[:user]], :order => "created_at")
    respond_to do |format|
      format.js
    end
  end

  def switch
    @to_do_list = ToDoList.find(params[:id].to_i)
    case @to_do_list.status
    when "new" then @to_do_list.status = "processing"
    when "processing" then @to_do_list.status = "completed"
    when "completed" then @to_do_list.status = "new"
    end
    @to_do_list.save
    @new_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "new", session[:user]], :order => "created_at")
    @processing_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "processing", session[:user]], :order => "created_at")
    @completed_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "completed", session[:user]], :order => "created_at")
    respond_to do |format|
      format.js
    end
  end

  def edit
    @to_do_list = ToDoList.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def show
    @to_do_list = ToDoList.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def update
    @to_do_list = ToDoList.find(params[:id].to_i)
    @to_do_list.update_attributes(params[:to_do_list])
    @new_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "new", session[:user]], :order => "created_at")
    @processing_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "processing", session[:user]], :order => "created_at")
    @completed_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "completed", session[:user]], :order => "created_at")
    respond_to do |format|
      format.js
    end
  end
end
