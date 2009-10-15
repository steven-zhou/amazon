class TagsController < ApplicationController

  def new
    @tag = (TagMetaType::OPTIONS[params[:tag].to_i]+"Type").camelize.constantize.new
    @tag_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaType").camelize.constantize.find(params[:tag_type_id])
    @tag_meta_type = @tag_type.tag_meta_type
    @tags = @tag_type.tags
    respond_to do |format|
      format.js
    end
  end

  def create
    @tag = (params[:type]).camelize.constantize.new(params[params[:type].underscore.to_sym])
    @tag_type = (params[:tag_type]).camelize.constantize.find(params[:tag_type_id])
    @tag_type.tags << @tag
    if @tag.save
      flash.now[:message] ||= " Saved successfully"
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag.errors.on(:name).nil? &&  @tag.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag.errors.on(:name).nil? &&  @tag.errors.on(:name)[0] == "has already been taken")
    end
  end

  def edit
    @tag = (TagMetaType::OPTIONS[params[:tag].to_i]+"Type").camelize.constantize.find(params[:id])
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
    @person_group = PersonGroup.find(params[:person_group_id]) rescue @person_group = PersonGroup.new
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @tag = (TagMetaType::OPTIONS[params[:tag].to_i]+"Type").camelize.constantize.find(params[:id])
    @tag_type = @tag.tag_type
    @tag.destroy
    
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

  def create_custom_sub_group
    @custom_group = GroupMetaType.find_by_id(params[:id])
    @sub_group = GroupType.new(:tag_type_id => @custom_group.id)
    @sub_group.update_attributes(params[:group_type])
    if @sub_group.save
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @sub_group.errors.on(:name)[0] + ", saved unsuccessfully." unless sub_group.on(:name).nil?
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
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @sub_group.errors.on(:name)[0] + ", saved unsuccessfully." unless sub_group.on(:name).nil?
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
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @table_attribute.errors.on(:name)[0] + ", saved unsuccessfully." unless @table_attribute.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

end
