class TagTypesController < ApplicationController

  before_filter :check_authentication

  def new
    @tag_type = (params[:tag]+"MetaType").camelize.constantize.new
    @tag_meta_type = (params[:tag]+"MetaMetaType").camelize.constantize.find(params[:tag_meta_type_id])
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
      flash[:message] = "Tag Type was saved"
    else
      flash[:warning] = "Tag Type wasn't saved"
    end
  end

  def edit
    @tag_type = (params[:tag]+"MetaType").camelize.constantize.find(params[:id])
    @tag_meta_type = @tag_type.tag_meta_type
    @tag_types = @tag_meta_type.tag_types.find(:all, :order => "name")
    @tags = @tag_type.tags.find(:all, :order => "name")
    @tag = (params[:tag]+"Type").camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def update
    @tag_type = (params[:type]).camelize.constantize.find(params[:id].to_i)
    if @tag_type.update_attributes(params[params[:type].underscore.to_sym])
      flash[:message] = "Tag Type was updated"
    else
      flash[:warning] = "Tag Type was not updated"
    end
    respond_to do |format|
      format.js
    end
  end
end
