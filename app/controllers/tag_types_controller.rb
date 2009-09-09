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
    respond_to do |format|
      format.js
    end
  end
end
