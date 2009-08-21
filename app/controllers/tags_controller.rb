class TagsController < ApplicationController

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
    @tag_type = (params[:tag_type]).camelize.constantize.find(params[:tag_type_id])
    @tag_type.tags << @tag
    if @tag.save
      flash[:message] = "Tag was saved"
    else
      flash[:warning] = "Tag wasn't saved"
    end
  end

  def edit
    @tag = (params[:tag]+"Type").camelize.constantize.find(params[:id])
    @tag_type = @tag.tag_type
    @tag_meta_type = @tag_type.tag_meta_type
    @tags = @tag_type.tags
    respond_to do |format|
      format.js
    end
  end

  def update
    @tag = (params[:type]).camelize.constantize.find(params[:id].to_i)
    if @tag.update_attributes(params[params[:type].underscore.to_sym])
      flash[:message] = "Tag was updated"
    else
      flash[:warning] = "Tag was not updated"
    end
    respond_to do |format|
      format.js
    end
  end
end
