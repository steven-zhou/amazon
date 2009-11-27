class UserGroupsController < ApplicationController
  # System Logging added

  def edit
    @group = GroupType.find(params[:data_id])
    @login_accounts = @group.login_accounts
    @user_group = UserGroup.new
    @user_groups = @group.user_groups

    respond_to do |format|
      format.js
    end

  end

  def create
    @login_account = SystemUser.find_by_user_name(params[:user_name])
    @person = @login_account.person rescue @person = Person.new
    unless @login_account.nil? && @person.new_record?
      @user_group = UserGroup.new(:user_id => @login_account.id, :group_id => params[:user_group][:group_id])
      if @user_group.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created User Group #{@user_group.id}.")
        flash.now[:message] = "saved successfully"
        @login_account = @user_group.login_account
        @group_meta_type = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"])rescue  @group_meta_types =  GroupMetaType.new
        @group_types = @group_meta_type.group_types rescue  @group_types =  GroupType.new
        @select_group_type_id = @user_group.group_type.id
      else
        flash.now[:error]= flash_message(:type => "field_missing", :field => "login_id")if(!@user_group.errors[:user_id].nil? && @user_group.errors.on(:user_id).include?("can't be blank"))
        flash.now[:error]= flash_message(:type => "user_group_uniqueness_error")if(!@user_group.errors[:user_id].nil? && @user_group.errors.on(:user_id).include?("has already been taken"))
      end

    else
      
      if @login_account.nil?
        flash.now[:error] = "the username is invalid"
      elsif @person.new_record?
        flash.now[:error] = "This LoginAccount's person information has been delete"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user_group = UserGroup.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted User Group #{@user_group.id}.")
    @user_group.destroy
    @group_meta_type = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"])rescue  @group_meta_types =  GroupMetaType.new
    @group_types = @group_meta_type.group_types rescue  @group_types =  GroupType.new

    respond_to do |format|
      format.js
    end
  end


end
