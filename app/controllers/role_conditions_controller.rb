class RoleConditionsController < ApplicationController

  def show_roles
    @role = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)
    respond_to do |format|
      format.js
    end
  end

  def add_conditions


  end

  def remove_conditions
    @role = Role.find(params[:role_id])
    unless params[:remove_doctype_id].nil?
      params[:remove_doctype_id].each do |doctype_id|
     
        @role_condition = @role.role_conditions.find(doctype_id)
       
        @role_condition.destroy

      end
    end
   
    respond_to do |format|

      format.js
      
    end

  end



  #new design--------------------------------------------
  def role_condition_show_roles
    @roles = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]],:order => 'id') unless (params[:role_type_id].nil? || params[:role_type_id].empty?)
    @role_type = RoleType.find(:first, :conditions => ["id=?",params[:role_type_id]])
    respond_to do |format|
      format.js
    end
  end

  def edit
    @role = Role.find(params[:role_id].to_i, :order => 'id')
    @role_condition = RoleCondition.new
    @role_conditions = @role.role_conditions
    respond_to do |format|
      format.js
    end
  end

  def condition_meta_type_finder
    @master_doc_meta_types = MasterDocMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", params[:master_doc_meta_meta_type_id].to_i],:order => 'name') rescue @master_doc_meta_types = MasterDocMetaType.new
    @master_doc_meta_meta_types = MasterDocMetaMetaType.find(params[:id],:order => 'name') rescue @master_doc_meta_meta_types = MasterDocMetaMetaType.new 
    respond_to do |format|
      format.js { }
    end
  end

  def doc_type_finder
    @master_doc_types = MasterDocType.find(:all, :conditions => ["tag_type_id = ?", params[:master_doc_meta_type_id].to_i],:order => 'name') rescue @master_doc_types = MasterDocType.new
    respond_to do |format|
      format.js { }
    end
  end

  def create

    unless params[:add_doctype_id].nil?
      #      params[:add_doctype_id].each do |doctype_id|
      @role_condition = RoleCondition.new
      @role_condition.role_id = params[:role_id]
      @role_condition.doctype_id = params[:add_doctype_id]
    end

    if @role_condition.save
      flash.now[:message] = "saved successfully"
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "doc")if(!@role_condition.errors[:doctype_id].nil? && @role_condition.errors.on(:doctype_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "role")if(!@role_condition.errors[:role_id].nil? && @role_condition.errors.on(:role_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "doc")if(!@role_condition.errors[:doctype_id].nil? && @role_condition.errors.on(:doctype_id).include?("has already been taken"))
    end
      
    @role = Role.find(params[:role_id])
     @role_conditions = @role.role_conditions
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @role_condition = RoleCondition.find(params[:id])
    @role_condition.destroy
    respond_to do |format|
      format.js
    end
  end

end
