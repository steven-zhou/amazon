class UserListsController < ApplicationController
  # System logging done...

  def edit
    id=params[:data_id].nil? ? params[:grid_object_id] : params[:data_id]
    @login_account = SystemUser.find(id)
    @list_headers = ListHeader.all
    @user_list = UserList.new
    @user_lists = @login_account.user_lists
    respond_to do |format|
      format.js
    end
  end

  def show_list_des
    @list_header = ListHeader.find(params[:list_id])
    respond_to do |format|
      format.js
    end
  end

  def create

    @user_list = UserList.new(params[:user_list])
    if @user_list.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created User List #{@user_list.id}.")
      flash.now[:message]= "saved successfully"
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "user_id")if (!@user_list.errors[:user_id].nil? &&@user_list.errors.on(:user_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "list_header_id")if (!@user_list.errors[:list_header_id].nil? && @user_list.errors.on(:list_header_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "list_header_id")if(!@user_list.errors[:list_header_id].nil? && @user_list.errors.on(:list_header_id).include?("has already been taken"))
    end
    @login_account = SystemUser.find(params[:user_list][:user_id])
     @login_accounts = SystemUser.all
    @select_login_account_id = @login_account.id
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user_list = UserList.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted User List #{@user_list.id}.")
    @user_list.destroy
    @login_accounts = SystemUser.all
    @select_login_account_id = @user_list.user_id
    respond_to do |format|
      format.js
    end
  end

end
