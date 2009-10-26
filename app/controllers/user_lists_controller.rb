class UserListsController < ApplicationController

  def edit
    @login_account = LoginAccount.find(params[:data_id])
    @list_headers = ListHeader.find :all
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
      flash.now[:message]= "saved successfully"
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "user_id")if (!@user_list.errors[:user_id].nil? &&@user_list.errors.on(:user_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "list_header_id")if (!@user_list.errors[:list_header_id].nil? && @user_list.errors.on(:list_header_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "list_header_id")if(!@user_list.errors[:list_header_id].nil? && @user_list.errors.on(:list_header_id).include?("has already been taken"))
    end
    @login_account = LoginAccount.find(params[:user_list][:user_id])
     @login_accounts = LoginAccount.find(:all)
    @select_login_account_id = @login_account.id
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user_list = UserList.find(params[:id])
    @user_list.destroy
    @login_accounts = LoginAccount.find(:all)
    @select_login_account_id = @user_list.user_id
    respond_to do |format|
      format.js
    end
  end

end