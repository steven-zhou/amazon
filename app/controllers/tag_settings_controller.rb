class TagSettingsController < ApplicationController

  before_filter :check_authentication

  def show_all_for_selected_classifier
    @tag_meta_types = (params[:tag]+"MetaMetaType").camelize.constantize.find(:all, :order => "name")
    @tag_meta_type = (params[:tag]+"MetaMetaType").camelize.constantize.new
    respond_to do |format|
      format.js
    end
  end
  
end
