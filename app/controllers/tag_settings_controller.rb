class TagSettingsController < ApplicationController

  before_filter :check_authentication  

  def show_all_for_selected_classifier
    @tag_meta_types = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.find(:all, :order => "name")
    @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.find(params[:id].to_i) rescue @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.new
    puts "DEBUG -- #{@tag_meta_type.to_yaml}"
    respond_to do |format|
      format.js
    end
  end
  
end
