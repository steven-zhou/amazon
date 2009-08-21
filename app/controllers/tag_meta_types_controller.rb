class TagMetaTypesController < ApplicationController

  def new
    @tag_meta_type = (params[:tag]+"MetaMetaType").camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @tag_meta_type = (params[:tag]+"MetaMetaType").camelize.constantize.find(params[:id])
    @tag_types = @tag_meta_type.tag_types
    @tag_type = (params[:tag]+"MetaType").camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @tag_meta_type = params[:type].camelize.constantize.new(params[params[:type].underscore.to_sym])
    if @tag_meta_type.save
      flash[:message] = "Tag Meta Type was saved"
    else
      flash[:warning] = "Tag Meta Type was not saved"
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @tag_meta_type = params[:type].camelize.constantize.find(params[:id].to_i)
    if @tag_meta_type.update_attributes(params[params[:type].underscore.to_sym])
      flash[:message] = "Tag Meta Type was updated"
    else
      flash[:warning] = "Tag Meta Type was not updated"
    end
    respond_to do |format|
      format.js
    end
  end


end
