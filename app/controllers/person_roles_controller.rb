class PersonRolesController < ApplicationController
  # Added system logging

  def create
    @person = Person.find(params[:person_id].to_i)
    @person_role = @person.person_roles.new(params[:person_role])
    if @person_role.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Person Role #{@person_role.id}.")
    else
    flash.now[:error]= flash_message(:type => "uniqueness_error", :field => "Role")if(!@person_role.errors[:role_id].nil? && @person_role.errors.on(:role_id).include?("has already been taken"))
    flash.now[:error]= "Please Enter All Required Data"if(!@person_role.errors[:role_id].nil? && @person_role.errors.on(:role_id).include?("can't be blank"))
    
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @person_role = PersonRole.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def edit
    @person_role = PersonRole.find(params[:id].to_i)
    @role = @person_role.role
    @role_type = @role.role_type
    @roles = @role_type.roles.find(:all, :order => 'name')
    @person = @person_role.role_player
    @masterdoc = @person.master_docs
    
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @person_role = PersonRole.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Person Role #{@person_role.id}.")
    @person_role.destroy

    respond_to do |format|
      format.js
    end
  end

  def update
    @person_role = PersonRole.find(params[:id].to_i)
    
     @temp = !params[:person_role][@person_role.id.to_s][:role_id].nil?
   if !params[:person_role][@person_role.id.to_s][:role_id].nil?
     if @person_role.update_attributes(params[:person_role][@person_role.id.to_s])
     system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Person Role #{@person_role.id}.")
     else
    
     flash.now[:error]= flash_message(:type => "uniqueness_error", :field => "Role")if(!@person_role.errors[:role_id].nil? && @person_role.errors.on(:role_id).include?("has already been taken"))
     end

   else
    flash.now[:error]= "Please Enter All Required Data"
    
   end
     respond_to do |format|
      format.js {render "show.js"}
    end

  end



end
