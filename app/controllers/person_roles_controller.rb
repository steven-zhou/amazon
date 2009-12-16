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
      flash.now[:error]= "Please Enter All Required Data"if(!@person_role.errors[:assigned_by].nil? && @person_role.errors.on(:assigned_by).include?("can't be blank"))
      flash.now[:error]= "Please Enter All Required Data"if(!@person_role.errors[:start_date].nil? && @person_role.errors.on(:start_date).include?("can't be blank"))
      flash.now[:error]= "You must specify a person that exists."if(!@person_role.errors[:role_assigner].nil? && @person_role.errors.on(:role_assigner).include?("You must specify a person that exists."))
      flash.now[:error]= "You must specify a person that exists."if(!@person_role.errors[:role_approver].nil? && @person_role.errors.on(:role_approver).include?("You must specify a person that exists."))
      flash.now[:error]= "You must specify a person that exists."if(!@person_role.errors[:role_superviser].nil? && @person_role.errors.on(:role_superviser).include?("You must specify a person that exists."))
      flash.now[:error]= "You must specify a person that exists."if(!@person_role.errors[:role_manager].nil? && @person_role.errors.on(:role_manager).include?("You must specify a person that exists."))
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @person_role = PersonRole.find(params[:id].to_i)
    @temp=true #to pass the show.js becasue add a @temp in update
    respond_to do |format|
      format.js
    end
  end

  def edit
    @person_role = PersonRole.find(params[:id].to_i)
    @role = @person_role.role
    @role_type = @role.role_type

    #if the role_type of current role is set to 'to_be_removed',
    #then get the first role_type whose 'to_be_removed = false'
    if @role_type.to_be_removed
      @temp = RoleType.active_role_type.first
      @roles = @temp.roles.find(:all, :conditions=>["to_be_removed = false"], :order=>'name') rescue @roles= Array.new
    else
      @roles = @role_type.roles.find(:all, :conditions=>["to_be_removed = false"],:order => 'name')
    end
    
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
        flash.now[:error]= "Please Enter All Required Data"if(!@person_role.errors[:role_id].nil? && @person_role.errors.on(:role_id).include?("can't be blank"))
        flash.now[:error]= "Please Enter All Required Data"if(!@person_role.errors[:assigned_by].nil? && @person_role.errors.on(:assigned_by).include?("can't be blank"))
        flash.now[:error]= "Please Enter All Required Data"if(!@person_role.errors[:start_date].nil? && @person_role.errors.on(:start_date).include?("can't be blank"))
      end

    else
      flash.now[:error]= "Please Enter All Required Data"
    
    end
    respond_to do |format|
      format.js {render "show.js"}
    end

  end



end
