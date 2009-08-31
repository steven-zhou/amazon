class EmailsController < ApplicationController

  before_filter :check_authentication

  def show
    @email = Email.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
    @email = @entity.emails.new(params[:email])
    @email.save
    respond_to do |format|
      format.js
    end
  end

  def edit
    @email = Email.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @email = Email.find(params[:id].to_i)
    respond_to do |format|
      if @email.update_attributes(params[:email])  
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @email = Email.find(params[:id].to_i)
    @email.destroy
    respond_to do |format|
      format.js
    end
  end

end
