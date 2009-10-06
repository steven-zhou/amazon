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
    @entity = Person.find(params[:person_id]) rescue @entity = Organisation.find(params[:organisation_id])
    @address = @entity.addresses.new(params[:address])
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

  def search_postcodes
    @postcodes = DomesticPostcode.find(:all, :conditions => ["suburb ILIKE ? AND state ILIKE ? AND postcode LIKE ?", "%#{params[:suburb]}%", "%#{params[:state]}%", "%#{params[:postcode]}%"])
    respond_to do |format|
      format.js
    end
  end

end
