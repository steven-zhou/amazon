class UserGroupsController < ApplicationController
  # System Logging added

  def edit
    id = params[:data_id].nil? ? params[:grid_object_id] : params[:data_id]
    @group = GroupType.find(id)
    @login_accounts = @group.login_accounts
    @user_group = UserGroup.new
    @user_groups = @group.user_groups

    respond_to do |format|
      format.js
    end

  end

  def create
    @login_account = SystemUser.find_by_name(params[:user_name])
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



  def mutiple_create
    @login_account = SystemUser.find_by_id(params[:grid_object_id])
  
    @user_group = UserGroup.new(:user_id => @login_account.id, :group_id => params[:params2])
    @group_types = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"]).group_types
   
    if @user_group.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created User Group #{@user_group.id}.")
      flash.now[:message] = "saved successfully"
      @select_group_type_id = @user_group.group_type.id
      @group = GroupType.find(params[:params2])
      @slg = ShowListGrid.find(:first, :conditions => ["login_account_id=? and grid_object_id=?", session[:user], @login_account.id])
      @slg.field_6 = false
      @slg.save      
    else
      flash.now[:error]= flash_message(:type => "field_missing", :field => "login_id")if(!@user_group.errors[:user_id].nil? && @user_group.errors.on(:user_id).include?("can't be blank"))
      flash.now[:error]= flash_message(:type => "user_group_uniqueness_error")if(!@user_group.errors[:user_id].nil? && @user_group.errors.on(:user_id).include?("has already been taken"))
    end
    respond_to do |format|
      format.js
    end
      
  end



  def destroy
    @user_group = UserGroup.find(params[:id])
    
    @user_group.destroy
    @group_meta_type = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"])rescue  @group_meta_types =  GroupMetaType.new
    @group_types = @group_meta_type.group_types rescue  @group_types =  GroupType.new
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted User Group #{@user_group.id}.")
    respond_to do |format|
      format.js
    end
  end

  def general_show_all_objects
    @group = GroupType.find(params[:object_id])
    show_list_recreate
  end

  private

  def show_list_recreate
    @group_login_accounts = @group.login_accounts
    @rest_login_accounts = SystemUser.all - @group_login_accounts
    ShowListGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    #---------------we do the system user only------------
    @rest_login_accounts.each do |login_account|
      @slg = ShowListGrid.new
      @slg.login_account_id = session[:user]
      @slg.grid_object_id = login_account.id
      @slg.field_1 = login_account.user_name
      @slg.field_2 = login_account.person.first_name
      @slg.field_3 = login_account.person.family_name
      @slg.field_4 = login_account.security_email
      @slg.field_5 = login_account.login_status
      @slg.field_6 = true
      @slg.save
    end
  end


end
