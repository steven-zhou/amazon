class GroupPermissionsController < ApplicationController

  def show_add_container
    @group_type = GroupType.find(params[:group_id])
    @group_permission = GroupPermission.new
    @group_permissions = @group_type.system_permission_types
    #puts"---DEBUG111---#{params[:group_id].to_yaml}"
    @module_all = Array.new
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

  #  def show_methods
  #    @system_permission_meta_type = SystemPermissionMetaType.find(params[:controller_id])  #controller
  #    @system_permission_types = @system_permission_meta_type.system_permission_types
  #    #puts"---DEBUG991---#{@system_permission_types.to_yaml}"
  #     respond_to do |format|
  #      format.js
  #    end
  #
  #  end

  def create

    #    #puts"-----dbug-----#{params[:system_permission_meta_meta_type][:name].to_yaml}"
    #
    #    unless params[:module_ids].blank?
    #      #puts"---DEBUG[111]---#{params[:module_ids][]}"
    #      #puts"---DEBUG[222]-#{params[:module_ids]}"
    #      @system_permission_meta_meta_type = SystemPermissionMetaMetaType.find(params[:module_id])
    #      @system_permission_meta_meta_type.system_permission_meta_types.each do |controller|
    #        #puts"-----dbug-----#{controller.to_yaml}"
    #        controller.system_permission_types.each do |method|
    #          @group_permission = GroupPermission.new(:user_group_id => params[:group_id], :system_permission_type_id => method.id)
    #
    #          @group_permission.save!
    #        end
    #      end
    #
    #    end

    if params[:module_ids].blank?

      unless params[:method_ids].blank?
        params[:method_ids].each do |method_id|
          #        @system_permission_type = SystemPermissionType.find_all_by_id(method_id)
          #         @system_permission_meta_type = SystemPermissionType.find_all_by_id(method_id)
          @group_permission = GroupPermission.new(:user_group_id => params[:group_id], :system_permission_type_id => method_id)
          @group_permission.save!

        end
      end

    else

      @system_permission_meta_meta_type = SystemPermissionMetaMetaType.find(params[:module_id])
      @system_permission_meta_meta_type.system_permission_meta_types.each do |controller|
        #puts"-----dbug-----#{controller.to_yaml}"
        controller.system_permission_types.each do |method|
          @group_permission = GroupPermission.new(:user_group_id => params[:group_id], :system_permission_type_id => method.id)

          @group_permission.save!
        end
      end

    end

    @group_type = GroupType.find(params[:group_id])
    @group_permissions = @group_type.group_permissions

    respond_to do |format|
      format.js
    end
  end

   def destroy

    @group_permission = GroupPermission.find(params[:id].to_i)
    @group_permission.destroy

    respond_to do |format|
      format.js
    end
  end


  
end