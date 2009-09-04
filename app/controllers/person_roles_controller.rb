class PersonRolesController < ApplicationController

  def create
    @person = Person.find(params[:person_id].to_i)
    @person_role = @person.person_roles.new(params[:person_role])
    @person_role.save
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
    @person_role.destroy

    respond_to do |format|
      format.js
    end
  end

  def update
    @person_role = PersonRole.find(params[:id].to_i)
    @person_role.update_attributes(params[:person_role][@person_role.id.to_s])
    render "show.js"
  end



end
