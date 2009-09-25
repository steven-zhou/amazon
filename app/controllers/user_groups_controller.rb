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

  def show_groups
    #@group_meta_meta_types = GroupMetaMetaType.find_by_name("Security",:order => "name")rescue  @group_meta_meta_types =  GroupMetaMetaType.new
    #@group_meta_types = GroupMetaType.find(:first, :conditions => ["tag_meta_type_id=? AND name=?", @group_meta_meta_types.id, "System Users"])rescue  @group_meta_types =  GroupMetaType.new
    #gp_id = @group_meta_types.id
    @group_meta_type = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"])rescue  @group_meta_types =  GroupMetaType.new
    #@group_types = GroupType.find(:all, :conditions => ["tag_type_id=?", gp_id])rescue  @group_types =  GroupType.new
    @group_types = @group_meta_type.group_types rescue  @group_types =  GroupType.new
    @login_account = LoginAccount.find(params[:login_account_id])
    @groups = @login_account.group_types
    respond_to do |format|
      format.js
    end

  end
end
