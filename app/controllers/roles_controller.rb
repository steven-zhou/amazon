class RolesController < ApplicationController
  # Login controller done

  def get_roles

    @person_role = PersonRole.find(params[:person_role_id].to_i) rescue @person_role = PersonRole.new
    @role = Role.find(:all, :conditions => ["role_type_id=? and role_status=? and to_be_removed = false",params[:role_type_id],true]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)

    @role_type = RoleType.find(:first, :conditions => ["id=? and to_be_removed = false",params[:role_type_id]])unless (params[:role_type_id].nil? || params[:role_type_id].empty?)

    respond_to do |format|
      format.js
    end
  end

  def person_role_des
    @person_role = PersonRole.find(params[:person_role_id].to_i) rescue @person_role = PersonRole.new
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

    array_after = array1 & array2
    @array_diff = Array.new
    @array_diff = array1 - array_after

    if ((array1 & array2) == array1)
      flash.now[:message] = "Message: &nbsp&nbsp Selected Person Matches Role Conditions"
    else
      flash.now[:warning] = "Warning: &nbsp&nbsp Selected Person Does Not Match Role Conditions"
    end
    respond_to do |format|
      format.js { }
    end
  end

  def meta_name_finder

    @master_doc_meta_meta_types = MasterDocMetaMetaType.find(params[:id].to_i) rescue @master_doc_meta_meta_types = MasterDocMetaMetaType.new
   
    respond_to do |format|
      format.js { }
    end
  end

  def meta_type_name_finder
    @master_doc_meta_types = MasterDocMetaType.find(params[:id].to_i) rescue @master_doc_meta_types = MasterDocMetaType.new

    respond_to do |format|
      format.js { }
    end
  end

  def role_type_finder
    @role_type = RoleType.find(:all,:order => 'name')
    @role = Role.new
    respond_to do |format|
      format.js { }
    end
  end


  #/-------------this method for Role management when person select Role_type, show roles for them
  def show_roles
    @roles = Role.find_role_type_by_id(params[:role_type_id]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)
    @role_type = RoleType.find(:first, :conditions => ["id=?",params[:role_type_id]])
    @role_type_id = params[:role_type_id].nil? ? "" : params[:role_type_id]
    respond_to do |format|
      format.js
    end
  end


  def create
    @role = Role.new(params[:role])
    @role.to_be_removed = false
    @role_type_id = @role.role_type_id
    if @role.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Role #{@role.id}.")
      flash.now[:message] = "saved successfully"
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name")if(!@role.errors[:name].nil? && @role.errors.on(:name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name")if(!@role.errors[:name].nil? && @role.errors.on(:name).include?("has already been taken"))
    end
    @roles = Role.find_role_type_by_id(params[:role][:role_type_id]) unless (params[:role][:role_type_id].nil? || params[:role][:role_type_id].empty?)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.to_be_removed = true
    @role.save!
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) remove Role, ID: #{@role.id}.")
    @role_type = @role.role_type
    @roles = Role.find_role_type_by_id(@role_type.id)
    respond_to do |format|
      format.js
    end
  end

  def delete_roles
    @role = Role.find(params[:id])
    @role.to_be_removed = true
    @role.save!
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) remove Role, ID: #{@role.id}.")
    @role_type = @role.role_type
    @roles = Role.find_role_type_by_id(@role_type.id)
    @role_type_id = @role_type.id
    respond_to do |format|
      format.js
    end
  end

  def edit
    @role = Role.find(params[:id].to_i, :order => 'name')
    respond_to do |format|
      format.js
    end
  end

  def update
    @role = Role.find(params[:id].to_i)
    if @role.update_attributes(params[:role])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Role #{@role.id}.")
      @role_type = @role.role_type
      @roles = @role_type.roles
    end
    respond_to do |format|
      format.js
    end
  end

  def page_initial

    @render_page = params[:render_page]
    @field = params[:field]
    @role = Role.new

    respond_to do |format|
      format.js
    end
  end
  
 

  def retrieve
    @role = Role.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieve Role ID #{@role.id}.")
    @role.to_be_removed = false
    @role.save!
    @role_type = @role.role_type
    @roles = Role.find_role_type_by_id(@role_type.id)
    @role_type_id = @role_type.id
    respond_to do |format|
      format.js
    end
  end


end
