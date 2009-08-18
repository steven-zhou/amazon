class AdministrationsController < ApplicationController
  def index
    @amazonsetting = AmazonSetting.new
    @master_doc_meta_meta_type = MasterDocMetaMetaType.new
    @master_doc_meta_type = MasterDocMetaType.new
    @master_doc_type = MasterDocType.new
    @role = Role.new
    @role_condition = RoleCondition.new
    respond_to do |format|
      format.html
    end
  end
end
