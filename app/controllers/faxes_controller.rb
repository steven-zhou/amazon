class FaxesController < ApplicationController

  before_filter :check_authentication
  
  def show
    @fax = Fax.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @person = Person.find(params[:person_id])
    @fax = @person.faxes.new(params[:fax])
    @fax.save
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
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @fax = Fax.find(params[:id])
    @fax.destroy
    respond_to do |format|
      format.js
    end
  end

end
