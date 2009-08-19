class RolesController < ApplicationController

  
  def get_roles

    @person_role = PersonRole.find(params[:person_role_id]) rescue @person_role = PersonRole.new
    @role = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)

    respond_to do |format|
      format.js
    end
  end

  def new
    @role_type = RoleType.find(:first, :conditions => ["id=?",params[:role_type_id]])
  
   
    @role = Role.find(params[:id]) rescue @role = Role.new
    #@role = Role.new if @role.nil?
    @role_condition = RoleCondition.new
    #puts "debug ----#{@role.to_yaml}"
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @role = Role.new(params[:role])
    @role.save
    respond_to do |format|
      format.js
    end
  end
    
  def master_doc_meta_type_finder1
 
    @master_doc_meta_types = MasterDocMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", params[:master_doc_meta_meta_type_id].to_i]) rescue @master_doc_meta_types = MasterDocMetaType.new
  


    #@master_doc_meta_meta_types = MasterDocMetaMetaType.find(:first, :conditions => ["id = ?", params[:master_doc_meta_meta_type_id].to_i])
    @master_doc_meta_meta_types = MasterDocMetaMetaType.find(params[:id]) rescue @master_doc_meta_meta_types = MasterDocMetaMetaType.new
    #puts "debbb---#{@master_doc_meta_meta_types.to_yaml}"
    respond_to do |format|
      format.js { }
    end
  end

  def meta_name_finder

    @master_doc_meta_meta_types = MasterDocMetaMetaType.find(params[:id]) rescue @master_doc_meta_meta_types = MasterDocMetaMetaType.new
   
    respond_to do |format|
      format.js { }
    end
  end

  def meta_type_name_finder
    @master_doc_meta_types = MasterDocMetaType.find(params[:id]) rescue @master_doc_meta_types = MasterDocMetaType.new

    #puts "debug----#{@master_doc_meta_types.to_yaml}"
    respond_to do |format|
      format.js { }
    end
  end

  def doc_type_finder
     @master_doc_types = MasterDocType.find(:all, :conditions => ["tag_type_id = ?", params[:master_doc_meta_type_id].to_i]) rescue @master_doc_types = MasterDocType.new
    respond_to do |format|
      format.js { }
    end
  end


   def update

  @role = Role.find(params[:id])

    respond_to do |format|

      if @role.update_attributes(params[:role])

        format.js { render 'show.js' }

      end
    end
  end
 

end
