class GroupPermissionsController < ApplicationController

  def show_add_container
    @group_type = GroupType.find(params[:group_id])
    @group_permission = GroupPermission.new
    @group_permissions = @group_type.group_permissions
    #puts"---DEBUG111---#{params[:group_id].to_yaml}"
    @module_all = Array.new
    @module_all = SystemPermissionMetaMetaType.all

    respond_to do |format|
      format.js
    end
  end





  #  def show_methods
  #    @system_permission_meta_type = SystemPermissionMetaType.find(params[:controller_id])  #controller
  #    @system_permission_types = @system_permission_meta_type.system_permission_types
  #    #puts"---DEBUG991---#{@system_permission_types.to_yaml}"
  #     respond_to do |format|
  #      format.js
  #    end
  #
  #  end




  #  def new
  #
  #    @group_type = GroupType.find(params[:group_id])
  #    @group_permission = GroupPermission.new
  #    @group_permissions = @group_type.group_permissions
  #    @module_all = Array.new
  #    @module_all = SystemPermissionMetaMetaType.all
  #
  #    respond_to do |format|
  #      format.js
  #    end
  #
  #  end


  #*********new design************
  def edit
    @group_type = GroupType.find(params[:data_id])
    @group_permission = GroupPermission.new
    @group_permissions =  @group_type.group_permissions
    @module_all = SystemPermissionMetaMetaType.all
    respond_to do |format|
      format.js
    end
  end

  def show_module
    @group_type = GroupType.find(params[:group_id])
    @system_permission_meta_meta_type = SystemPermissionMetaMetaType.find(params[:system_permission_module_id])
    #@system_permission_meta_meta_types = SystemPermissionMetaMetaType.find(:all, :conditions => ["id=?", params[:system_permission_module_id]])
    #puts"---DEBUG222---#{@system_permission_meta_meta_type.to_yaml}"
    respond_to do |format|
      format.js
    end
  end

  def show_controllers
    @system_permission_meta_meta_type = SystemPermissionMetaMetaType.find(params[:main_module_id])
    @system_permission_meta_types = @system_permission_meta_meta_type.system_permission_meta_types
    #puts"---DEBUG991---#{@system_permission_meta_types.to_yaml}"
    respond_to do |format|
      format.js
    end
  end

  def destroy

    @group_permission = GroupPermission.find(params[:id].to_i)
    @group_permission.destroy
    @group_types = GroupType.system_user_groups

    respond_to do |format|
      format.js
    end
  end

  def create
    if params[:module_ids].blank?
      unless params[:method_ids].blank?
        params[:method_ids].each do |method_id|
          @group_permission = GroupPermission.new(:user_group_id => params[:group_id], :system_permission_type_id => method_id)
          if  @group_permission.save
            flash.now[:message]= "saved successfully"
          else
            flash.now[:error] = flash_message(:type => "field_missing", :field => "system_permission")if (!@group_permission.errors[:system_permission_type_id].nil? && @group_permission.errors.on(:system_permission_type_id).include?("can't be blank"))
            flash.now[:error] = flash_message(:type => "field_missing", :field => "group")if (!@group_permission.errors[:user_group_id].nil? && @group_permission.errors.on(:user_group_id).include?("can't be blank"))
          end
        end
      else
        flash.now[:error]= flash_message(:type => "field_missing", :field => "permission")
      end
    else
      @system_permission_meta_meta_type = SystemPermissionMetaMetaType.find(params[:module_id])
      @system_permission_meta_meta_type.system_permission_meta_types.each do |controller|
        #puts"-----dbug-----#{controller.to_yaml}"
        controller.system_permission_types.each do |method|
          @group_permission = GroupPermission.new(:user_group_id => params[:group_id], :system_permission_type_id => method.id)

          if @group_permission.save
            flash.now[:message]= "saved successfully"
          else
            flash.now[:error] = flash_message(:type => "field_missing", :field => "system_permission")if (!@group_permission.errors[:system_permission_type_id].nil? && @group_permission.errors.on(:system_permission_type_id).include?("can't be blank"))
            flash.now[:error] = flash_message(:type => "field_missing", :field => "group")if (!@group_permission.errors[:user_group_id].nil? && @group_permission.errors.on(:user_group_id).include?("can't be blank"))
          end
        end
      end

    end

    @group_type = GroupType.find(params[:group_id])
    @group_permissions = @group_type.group_permissions
    @module_all = Array.new
    @module_all = SystemPermissionMetaMetaType.all

    respond_to do |format|
      format.js
    end
  end


  
end