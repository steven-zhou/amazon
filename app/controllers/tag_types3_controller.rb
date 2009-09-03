class TagTypes3Controller < ApplicationController
  def show_tag_types
     @tag_meta_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaMetaType").camelize.constantize.find(params[:id])
     #@tag_type = (TagMetaType::OPTIONS[params[:tag].to_i]+"MetaType").camelize.constantize.find(params[:id])
     @tag_types = @tag_meta_type.tag_types.find(:all, :order => "name")
    respond_to do |format|
      format.js
    end

  
  end



end
