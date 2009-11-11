class FaxesController < ApplicationController
  # System logging stuff added...

  
  def show
    @fax = Fax.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
    @fax = @entity.faxes.new(params[:fax])
    @fax.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a Fax with ID #{@fax.id}.")
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @fax= Fax.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @fax = Fax.find(params[:id])
    respond_to do |format|
      if @fax.update_attributes(params[:fax])
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Fax with ID #{@fax.id}.")
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @fax = Fax.find(params[:id])
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Fax with ID #{@fax.id}.")
    @fax.destroy
    respond_to do |format|
      format.js
    end
  end

end
