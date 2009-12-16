class TagMetaTypesController < ApplicationController
  # System logging done

  def new
    @tag_meta_type = (params[:tag]+"MetaMetaType").camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @tag_meta_type = TagMetaType.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @tag_meta_type = params[:type].camelize.constantize.new(params[params[:type].underscore.to_sym])
    @category = params[:type].sub(/MetaMetaType/,"")
    if @tag_meta_type.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created new TagMetaType #{@tag_meta_type.id}.")
      flash.now[:message] = "Saved successfully"
    else
      #flash.now[:error] = "Name " + @tag_meta_type.errors.on(:name)[0] + ", saved unsuccessfully" unless @tag_meta_type.errors.on(:name).nil?
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag_meta_type.errors[:name].nil? && @tag_meta_type.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag_meta_type.errors[:name].nil? && @tag_meta_type.errors.on(:name)[0] == "has already been taken")
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @tag_meta_type = params[:type].camelize.constantize.find(params[:id].to_i)
    @category = params[:type].sub(/MetaMetaType/,"")
    if @tag_meta_type.update_attributes(params[params[:type].underscore.to_sym])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated TagMetaType #{@tag_meta_type.id}.")
      flash.now[:message] = "Updated successfully."
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag_meta_type.errors[:name].nil? && @tag_meta_type.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag_meta_type.errors[:name].nil? && @tag_meta_type.errors.on(:name)[0] == "has already been taken")
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @tag_meta_type = TagMetaType.find(params[:id])

#    if @tag_meta_type.type == "MasterDocMetaMetaType"
#      @tag_meta_type.remove_master_doc_meta_types
#    else
#    @tag_meta_type.destroy
#    end

   @tag_meta_type.to_be_removed = true
   @tag_meta_type.save
   @tag_meta_types = (@tag_meta_type.type.camelize.constantize).find(:all, :order => "name asc")
   
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted TagMetaType #{@tag_meta_type.id}.")
    respond_to do |format|
      format.js
    end
  end

  def show_group_types
    @group_meta_meta_type = GroupMetaMetaType.find(params[:group_meta_meta_type_id].to_i) rescue @group_meta_meta_type = GroupMetaMetaType.new
    @person_group = PersonGroup.find(params[:person_group_id]) rescue @person_group = PersonGroup.new
    @group_meta_types = @group_meta_meta_type.group_meta_types.find(:all, :order => "name")
   
    #@group_meta_types = @group_meta_meta_type.group_meta_types.find(:all,:order => "name")
    #@group_types = @group_meta_types.group_types.find(:all, :order => "name")
  respond_to do |format|
     format.js
    end
  end

  def access_permission_finder
    @access_permissions = SystemPermissionMetaMetaType.find(:all)
    respond_to do |format|
      format.js
    end
  end

  def create_access_permissions_meta_meta_type
    @access_permission = SystemPermissionMetaMetaType.new
    @access_permission.update_attributes(params[:system_permission_meta_meta_type])
    if @access_permission.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created SystemPermission #{@access_permission.id}.")
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @access_permission.errors.on(:name)[0] + ", saved unsuccessfully." unless @access_permission.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

   def retrieve
    @tag_meta_type = TagMetaType.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieve Amazon Setting ID #{@tag_meta_type.id}.")
    @tag_meta_type.retrieve_all_children
    @category = @tag_meta_type.type.to_s.sub(/MetaMetaType/,"")
    @tag_meta_types = (@tag_meta_type.type.camelize.constantize).find(:all, :order => "name asc")
    respond_to do |format|
      format.js
    end
  end

end


