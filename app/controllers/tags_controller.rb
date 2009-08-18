class TagsController < ApplicationController

  def show_all_for_selected_classifier
    @tag_meta_types = params[:type].camelize.constantize.all
    @tag_meta_type = params[:type].camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def tag_meta_type_new
    @tag_meta_type = params[:type].camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end

  def tag_meta_type_edit
    @tag_meta_type = params[:type].camelize.constantize.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

end
