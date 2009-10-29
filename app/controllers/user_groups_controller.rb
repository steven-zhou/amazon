class UserGroupsController < ApplicationController


  def add_security

    unless params[:add_group_id].nil?
      params[:add_group_id].each do |group_id|
        @user_group = UserGroup.new
        @user_group.user_id = params[:user_id]
        @user_group.group_id = group_id

        @user_group.save


      end
    end
    @login_account = LoginAccount.find(params[:user_id])
    @groups = @login_account.group_types
    respond_to do |format|

      format.js
    end
  end
  
  def remove_security

    @login_account = LoginAccount.find(params[:user_id])
    unless params[:remove_group_id].nil?
      params[:remove_group_id].each do |group_id|
        @user_group = @login_account.user_groups.find_by_group_id(group_id)
        @user_group.destroy
      end
    end
    #@groups = @login_account.group_types rescue @groups = GroupType.new
  end

  #  def show_groups
  #
  #    @group_meta_type = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"])rescue  @group_meta_types =  GroupMetaType.new
  #    @group_types = @group_meta_type.group_types rescue  @group_types =  GroupType.new
  #    @login_account = LoginAccount.find(params[:login_account_id])
  #    @groups = @login_account.group_types
  #    respond_to do |format|
  #      format.js
  #    end
  #
  #  end

  def show
    @group = GroupType.find(params[:group_type_id])
    @login_accounts = @group.login_accounts
    @user_group = UserGroup.new
    @user_groups = @group.user_groups

    respond_to do |format|
      format.js
    end

  end

  def create
    @login_account = LoginAccount.find_by_user_name(params[:user_name])
    @person = @login_account.person rescue @person = Person.new
    unless @login_account.nil? || @person.new_record?
      @user_group = UserGroup.new(:user_id => @login_account.id, :group_id => params[:user_group][:group_id])
      if @user_group.save
        flash.now[:message] = "saved successfully"
        @login_account = @user_group.login_account
        @group_meta_type = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"])rescue  @group_meta_types =  GroupMetaType.new
        @group_types = @group_meta_type.group_types rescue  @group_types =  GroupType.new
      else
        flash.now[:error]= flash_message(:type => "field_missing", :field => "login_id")if(!@user_group.errors[:user_id].nil? && @user_group.errors.on(:user_id).include?("can't be blank"))
        flash.now[:error]= flash_message(:type => "uniqueness_error", :field => "login_id")if(!@user_group.errors[:user_id].nil? && @user_group.errors.on(:user_id).include?("has already been taken"))
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
    @user_group.destroy
    @group_meta_type = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"])rescue  @group_meta_types =  GroupMetaType.new
    @group_types = @group_meta_type.group_types rescue  @group_types =  GroupType.new

    respond_to do |format|
      format.js
    end
  end

  def user_name_to_person
    @login_account = LoginAccount.find_by_user_name(params[:user_name])
    unless @login_account.nil?
      @person = @login_account.person
    end
    respond_to do |format|
      format.js
    end
  end

  

end
