class TagsController < ApplicationController

  before_filter :check_authentication

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
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if @tag.errors.on(:name)[0] == "can't be blank"
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if @tag.errors.on(:name)[0] == "has already been taken"
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
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if @tag.errors.on(:name)[0] == "can't be blank"
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if @tag.errors.on(:name)[0] == "has already been taken"
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
end
