class ToDoListsController < ApplicationController
  # System Log done

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
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a ToDoList #{@to_do_list.id}.")
      flash.now[:error] = flash_message(:type => "field_missing", :field => "description") if (!@to_do_list.errors[:description].nil? && @to_do_list.errors.on(:description).include?("can't be blank"))
    end
    @new_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "new", session[:user]], :order => "created_at")
    @processing_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "processing", session[:user]], :order => "created_at")
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @to_do_list = ToDoList.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted ToDoList #{@to_do_list.id}.")
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
    if @to_do_list.update_attributes(params[:to_do_list])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated ToDoList #{@to_do_list.id}.")
      @new_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "new", session[:user]], :order => "created_at")
      @processing_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "processing", session[:user]], :order => "created_at")
      @completed_to_do = ToDoList.find(:all, :conditions => ["status = ? AND login_account_id = ?", "completed", session[:user]], :order => "created_at")
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "description") if (!@to_do_list.errors[:description].nil? && @to_do_list.errors.on(:description).include?("can't be blank"))
    end
    respond_to do |format|
      format.js
    end
  end
end
