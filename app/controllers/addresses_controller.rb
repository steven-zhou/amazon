class AddressesController < ApplicationController

  
  def show
    @address = Address.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def edit
    @address = Address.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @person = Person.find(params[:person_id])
    @address = @person.addresses.new(params[:address])
    @address.save
    respond_to do |format|
      format.js
    end
  end

  def update
    @address = Address.find(params[:id])
    respond_to do |format|
      if @address.update_attributes(params[:address])  
        format.js { render 'show.js' }
      end
    end
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    respond_to do |format|
      format.js
    end
  end

end
