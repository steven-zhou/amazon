class RolesController < ApplicationController
  def show
  end

  def create
    @person = Person.find(params[:person_id])
    @person.roles << @role = Role.find(params[:role][:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @person = Person.find(params[:person_id])
    @person.roles.delete(@role = Role.find(params[:id]))
  end

end
