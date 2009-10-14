class TagTypesController < ApplicationController

  def new
    @tag_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaType").camelize.constantize.new
    @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.find(params[:tag_meta_type_id])
    @tag_types = @tag_meta_type.tag_types
    respond_to do |format|
      format.js
    end
  end

  def create
    @tag_type = (params[:type]).camelize.constantize.new(params[params[:type].underscore.to_sym])
    @tag_meta_type = (params[:tag_meta_type]).camelize.constantize.find(params[:tag_meta_type_id])
    @tag_meta_type.tag_types << @tag_type
    if @tag_type.save
      flash.now[:message] ||= " Saved successfully"
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag_type.errors.on(:name).nil? && @tag_type.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag_type.errors.on(:name).nil? && @tag_type.errors.on(:name)[0] == "has already been taken")
    end
  end

  def edit
    @tag_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaType").camelize.constantize.find(params[:id])
    @tag_meta_type = @tag_type.tag_meta_type
    @tag_types = @tag_meta_type.tag_types.find(:all, :order => "name")
    @tags = @tag_type.tags.find(:all, :order => "name")
    @tag = (TagMetaType::OPTIONS[params[:tag].to_i]+"Type").camelize.constantize.new
    @flag = String.new
    @flag = params[:flag]
    respond_to do |format|
      format.js
    end
  end

  def update
    @tag_type = (params[:type]).camelize.constantize.find(params[:id].to_i)
    @tag_meta_type = @tag_type.tag_meta_type
    if @tag_type.update_attributes(params[params[:type].underscore.to_sym])
      flash.now[:message] ||= " Updated successfully."
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@tag_type.errors.on(:name).nil? && @tag_type.errors.on(:name)[0] == "can't be blank")
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@tag_type.errors.on(:name).nil? && @tag_type.errors.on(:name)[0] == "has already been taken")
    end
    respond_to do |format|
      format.js
    end
  end

  def show_tag_types
    @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.find(params[:id])
    @tag_types = @tag_meta_type.tag_types.find(:all, :order => "name")
    respond_to do |format|
      format.js
    end
  end

  def show_fields
    @tag_types = TableMetaType.find(:all, :conditions => ["tag_meta_type_id=?", TableMetaMetaType.find_by_name(params[:table_name]).id], :order => "name")
    @update_field = String.new
    @update_value = String.new
    @update_field = params[:update_field]
    @update_value = params[:update_value]
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @tag_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaType").camelize.constantize.find(params[:id])
    @tag_meta_type = @tag_type.tag_meta_type
    
    @tags = @tag_type.tags.find(:all, :order => "name")unless @tag_type.tags.nil?
    #@tag = (TagMetaType::OPTIONS[params[:tag].to_i]+"Type").camelize.constantize.new
    #@flag = String.new
    #@flag = params[:flag]
    for i in @tags
    i.destroy
    end
    
    @tag_type.destroy


    respond_to do |format|
      format.js
    end
  end




  def show_types
    @group_meta_type = GroupMetaType.find(params[:group_meta_type_id].to_i) rescue @group_meta_type = GroupMetaType.new
    @person_group = PersonGroup.find(params[:person_group_id]) rescue @person_group = PersonGroup.new
#    @group_meta_types = @group_meta_meta_type.group_meta_types.find(:all, :order => "name")
#
#    @group_meta_types = @group_meta_meta_type.group_meta_types.find(:all,:order => "name")
    @group_types = @group_meta_type.group_types.find(:all, :order => "name")
  respond_to do |format|
     format.js
    end
  end

  def custom_groups_finder
    @custom_groups = GroupMetaMetaType.find_by_name("Custom")
    respond_to do |format|
      format.js
    end
  end

  def create_group_meta_type
    @custom_group = GroupMetaMetaType.find_by_name("Custom")
    @group_meta_type = GroupMetaType.new(:tag_meta_type_id => @custom_group.id)
    @group_meta_type.update_attributes(params[:group_meta_type])
    if @group_meta_type.save
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @group_meta_type.errors.on(:name)[0] + ", saved unsuccessfully." unless @group_meta_type.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

  def security_groups_finder
    @security_groups = GroupMetaMetaType.find_by_name("Security")
    respond_to do |format|
      format.js
    end
  end

  def create_security_group_meta_type
    puts "***** DEBUG I am being run!"
    @security_group = GroupMetaMetaType.find_by_name("Security")
    @group_meta_type = GroupMetaType.new(:tag_meta_type_id => @security_group.id)
    @group_meta_type.update_attributes(params[:group_meta_type])
    if @group_meta_type.save
      flash.now[:message] = "Saved successfully."
    else
      flash.now[:warning] = "Name " + @group_meta_type.errors.on(:name)[0] + ", saved unsuccessfully." unless @group_meta_type.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

end

