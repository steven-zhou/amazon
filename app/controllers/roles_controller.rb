class RolesController < ApplicationController

  before_filter :check_authentication

  def get_roles

    @person_role = PersonRole.find(params[:person_role_id]) rescue @person_role = PersonRole.new
    @role = Role.find(:all, :conditions => ["role_type_id=? and role_status=?",params[:role_type_id],true]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)
    @role_type = RoleType.find(:first, :conditions => ["id=?",params[:role_type_id]])unless (params[:role_type_id].nil? || params[:role_type_id].empty?)

    respond_to do |format|
      format.js
    end
  end

  def person_role_des
    @person_role = PersonRole.find(params[:person_role_id]) rescue @person_role = PersonRole.new
    @role = Role.find(:first, :conditions => ["id=?", params[:id].to_i])rescue @role = Role.new
    @person = Person.find(:first, :conditions => ["id=?", params[:person_id].to_i])

    array1 = Array.new
    array2 = Array.new
    unless @role.nil?
      @role.role_conditions.each do |r|
        array1 << r.doctype_id
      end
    end
    
      unless @person.master_docs.nil?
        @person.master_docs.each do |m|
          array2 << m.master_doc_type_id
        end
      end
     
        if ((array1 & array2) == array1)
          flash.now[:message] = "this person is a good choice."
        else
          flash.now[:warning] = "This person do not have enough qualifications."
        end
        respond_to do |format|
          format.js { }
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


  

      def role_type_finder
        @role_type = RoleType.find(:all)
        @role = Role.new
        respond_to do |format|
          format.js { }
        end
      end


      #/-------------this method for Role management when person select Role_type, show roles for them
      def show_roles
        #@role = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)
        @role_type_des = RoleType.find(:first, :conditions => ["id=?",params[:role_type_id]])rescue @role_type = RoleType.new
        #puts"debug--#{@role_type_des.to_yaml}"
        @role = Role.new
        @roles = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)
        @role_type = RoleType.find(:first, :conditions => ["id=?",params[:role_type_id]])
        respond_to do |format|
          format.js
        end
      end

      def new
        @role = Role.new
        @roles = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)
        #------------follow is for the hidden field of new form sumit get role_type_id
        @role_type = RoleType.find(:first, :conditions => ["id=?",params[:role_type_id]])
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

      def edit
        @role = Role.find(params[:id].to_i)
        @roles = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)
 
        @role_condition = RoleCondition.new
        respond_to do |format|
          format.js
        end
      end

      def update
        @role = Role.find(params[:id])
        @roles = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)
        #  puts"debug--#{@roles.to_yaml}"
        respond_to do |format|
          if @role.update_attributes(params[:role])
            format.js { render 'show.js' }
          end
        end
      end

    end
