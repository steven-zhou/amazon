class TagSettingsController < ApplicationController

  def show_all_for_selected_classifier
    @tag_meta_types = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.find(:all, :order => "name")
    respond_to do |format|
      format.js
    end
  end
  
end
