class TagsController < ApplicationController
  # System Logging done

  def new
    @tag = (params[:tag]+"Type").camelize.constantize.new
    @tag_type = (params[:tag]+"MetaType").camelize.constantize.find(params[:tag_type_id])
    @tag_meta_type = @tag_type.tag_meta_type
    @tags = @tag_type.tags
    respond_to do |format|
      format.js
    end
  end

  def create
    @tag = (params[:type]).camelize.constantize.new(params[params[:type].underscore.to_sym])
    @tag.to_be_removed = false
    @tag_type = (params[:tag_type]).camelize.constantize.find(params[:tag_type_id])
    @tag_type.tags << @tag
    if @tag.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Tag #{@tag.id}.")
      flash.now[:message] ||= " Saved successfully"
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag.errors.on(:name).nil? &&  @tag.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag.errors.on(:name).nil? &&  @tag.errors.on(:name)[0] == "has already been taken")
    end
  end

  def edit
    @tag = Tag.find(params[:id])
    @tag_type = @tag.tag_type
    @tag_meta_type = @tag_type.tag_meta_type
    @tags = @tag_type.tags
    respond_to do |format|
      format.js
    end
  end

  def update
    @tag = (params[:type]).camelize.constantize.find(params[:id].to_i)
    @tag_type = @tag.tag_type
    if @tag.update_attributes(params[params[:type].underscore.to_sym])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Tag #{@tag.id}.")
      flash.now[:message] ||= " Updated successfully."
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag.errors.on(:name).nil? && @tag.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag.errors.on(:name).nil? && @tag.errors.on(:name)[0] == "has already been taken")
    end
    respond_to do |format|
      format.js
    end
  end

  def show_tags
    @tag_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaType").camelize.constantize.find(params[:id])
    @tag = @tag_type.tags
    respond_to do |format|
      format.js
    end
  end

  def show_group_description
    @group_type = GroupType.find(params[:group_id].to_i) rescue @group_type = GroupType.new
    respond_to do |format|
      format.js
    end
  end

  def show_role_condition_description
    @role_conditon_description = MasterDocType.find(params[:doctype_id].to_i) rescue @role_conditon_description = MasterDocType.new
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag_type = @tag.tag_type
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Tag #{@tag.id}.")
    #    @tag.destroy
    @tag.to_be_removed = true
    @tag.save
    respond_to do |format|
      format.js
    end
  end

  def custom_sub_groups_finder
    @group = GroupMetaType.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def security_sub_groups_finder
    @group = GroupMetaType.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create_security_sub_group
    @security_group = GroupMetaType.find_by_id(params[:id])
    @sub_group = GroupType.new(:tag_type_id => @security_group.id)
    @sub_group.update_attributes(params[:group_type])
    if @sub_group.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created GroupMetaType #{@sub_group.id}.")
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @sub_group.errors.on(:name)[0] + ", saved unsuccessfully." unless @sub_group.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

  def security_sub_groups_finder
    @group = GroupMetaType.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create_security_sub_group
    @security_group = GroupMetaType.find_by_id(params[:id])
    @sub_group = GroupType.new(:tag_type_id => @security_group.id)
    @sub_group.update_attributes(params[:group_type])
    if @sub_group.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created GroupMetaType #{@sub_group.id}.")
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @sub_group.errors.on(:name)[0] + ", saved unsuccessfully." unless @sub_group.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

  def query_table_attributes_finder
    @query_table = TableMetaMetaType.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create_query_table_atttribute
    @query_table = TableMetaMetaType.find_by_id(params[:id])
    @table_attribute = TableMetaType.new(:tag_meta_type_id => @query_table.id)
    @table_attribute.update_attributes(params[:table_meta_type])
    if @table_attribute.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Query Table attribute #{@table_attribute.id}.")
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @table_attribute.errors.on(:name)[0] + ", saved unsuccessfully." unless @table_attribute.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end


  def delete_custom_group
    custom_group = GroupType.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Custom Group #{custom_group.id}.")
    custom_group.destroy
    @group = GroupMetaType.find(params[:custom_group_type_id])
    respond_to do |format|
      format.js
    end
  end


   def retrieve
    @tag = Tag.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieve Master Docs ID #{@tag.id}.")
    @tag_type = @tag.tag_type
    @tag.to_be_removed = false
    @tag.save
    respond_to do |format|
      format.js
    end
  end

end
