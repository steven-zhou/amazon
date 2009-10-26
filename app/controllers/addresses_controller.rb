class AddressesController < ApplicationController

  def show
    @address = Address.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def edit
    @postcodes = DomesticPostcode.find(:all)
    @address = Address.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @entity = Person.find(params[:person_id]) rescue @entity = Organisation.find(params[:organisation_id])
    @address = @entity.addresses.new(params[:address])
    @address.save
    @person = Person.find(session[:user])
    if (params[:organisation_id])
      @organisation = Organisation.find(params[:organisation_id])
    end
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

    if @address.addressable_type == "Person"             # if in Person return person object to destroy.js
      @current_object = Person.find(session[:user])
    end
    if @address.addressable_type == "Organisation"
      @current_object =Organisation.find(@address.addressable_id)  # if in organisation return organisation object to destroy.js
    end
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


  def move_down_address_priority

    @current_address = Address.find(params[:id])

    if(@current_address.priority_number==1)
      @exchange_address = @current_address.addressable.addresses.find_by_priority_number(2)
      
      @exchange_address.priority_number = 1
      @current_address.priority_number = 2
      @exchange_address.save
      @current_address.save
    end
    @person = Person.find(session[:user])
    respond_to do |format|
      format.js
    end

  end


  def move_up_address_priority
    @up_current_address = Address.find(params[:id])
    @up_exchange_address = @up_current_address.addressable.addresses.find_by_priority_number(@up_current_address.priority_number - 1)
    
    @up_exchange_address.priority_number = @up_exchange_address.priority_number + 1
    @up_current_address.priority_number = @up_current_address.priority_number - 1
    
    @up_exchange_address.save
    @up_current_address.save
    @person = Person.find(session[:user])

    respond_to do |format|
      format.js
    end
  end

  def move_down_organisation_address_priority
    @current_address = Address.find(params[:id])

    if(@current_address.priority_number==1)
      @exchange_address = @current_address.addressable.addresses.find_by_priority_number(2)

      @exchange_address.priority_number = 1
      @current_address.priority_number = 2
      @exchange_address.save
      @current_address.save
    end
    @organisation = Organisation.find(@current_address.addressable_id)
    respond_to do |format|
      format.js
    end
  end

  def move_up_organisation_address_priority
     @up_current_address = Address.find(params[:id])
    @up_exchange_address = @up_current_address.addressable.addresses.find_by_priority_number(@up_current_address.priority_number - 1)

    @up_exchange_address.priority_number = @up_exchange_address.priority_number + 1
    @up_current_address.priority_number = @up_current_address.priority_number - 1

    @up_exchange_address.save
    @up_current_address.save
     @organisation = Organisation.find(@up_current_address.addressable_id)
    respond_to do |format|
      format.js
    end

  end
end
