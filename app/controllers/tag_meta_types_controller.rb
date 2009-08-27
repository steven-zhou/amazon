class TagMetaTypesController < ApplicationController

  before_filter :check_authentication

  def new
    @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.find(params[:id])
    @tag_types = @tag_meta_type.tag_types.find(:all, :order => "name")
    @tag_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaType").camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @tag_meta_type = params[:type].camelize.constantize.new(params[params[:type].underscore.to_sym])
    if @tag_meta_type.save
      flash.now[:message] = "Saved successfully"
    else
      flash.now[:warning] = "Name " + @tag_meta_type.errors.on(:name)[0] + ", saved unsuccessfully" unless @tag_meta_type.errors.on(:name).nil?
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @tag_meta_type = params[:type].camelize.constantize.find(params[:id].to_i)
    if @tag_meta_type.update_attributes(params[params[:type].underscore.to_sym])
      flash.now[:message] = "Updated successfully."
    else
      flash.now[:warning] = "Name " + @tag_meta_type.errors.on(:name)[0] + ", updated unsuccessfully."
    end
    respond_to do |format|
      format.js
    end
  end


end
