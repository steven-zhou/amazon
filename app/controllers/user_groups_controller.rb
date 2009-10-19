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
    puts"-----DEBUG---#{@login_accounts.to_yaml}"
    @user_group = UserGroup.new

    respond_to do |format|
      format.js
    end

  end

  def create
    @user_group = UserGroup.new(params[:user_group])
    puts"--DEBUG#############---#{@user_group.to_yaml}"
     @login_account = @user_group.login_account
    if @user_group.save
      flash.now[:message] = "saved successfully"
     
      puts"--DEBUG#############---#{@login_account.to_yaml}"
    else
      flash.now[:error]= flash_message(:type => "field_missing", :field => "system_id")if(!@user_group.errors[:user_id].nil? && @user_group.errors.on(:user_id).include?("can't be blank"))
      
      flash.now[:error]= flash_message(:type => "uniqueness_error", :field => "system_id")if(!@user_group.errors[:user_id].nil? && @user_group.errors.on(:user_id).include?("has already been taken"))
      puts"--DEBUG---eeeerrrorororo"
    end

    respond_to do |format|
      format.js
    end
  end

end
