class AdministrationsController < ApplicationController
  def index
    @amazonsetting = AmazonSetting.new
    @tag_meta_type = TagMetaType.new
    @tag_type = TagType.new
    @tag = Tag.new
    respond_to do |format|
      format.html
    end
  end
end
