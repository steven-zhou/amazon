class AddressesController < ApplicationController
  # System Log stuff added

  def show
    @address = Address.find(params[:id])
    @address_new = Address.new
    @countries = Country.all
    @active_address = AddressType.active_address_type
    if @address.addressable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@address.addressable_id)
    else
      @organisation =Organisation.find(@address.addressable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    #    @countries = Country.all
    #    @active_address = AddressType.active_address_type
    @address = Address.find(params[:id])
    if @address.addressable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@address.addressable_id)
    else
      @organisation =Organisation.find(@address.addressable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      format.js
    end
  end

  def create
    @entity = Person.find(params[:person_id]) rescue @entity = Organisation.find(params[:organisation_id])
    @address = @entity.addresses.new(params[:address])
    @countries = Country.all
    @active_address = AddressType.active_address_type
    @address.save
    if @entity.class.to_s == "Person"
      @person = Person.find(@address.addressable_id)
    else
      @organisation = Organisation.find(@address.addressable_id)
    end
    @address_new = Address.new
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new address entry with ID #{@address.id}.")
    respond_to do |format|
      format.js
    end
  end

  def update
    @countries = Country.all
    @active_address = AddressType.active_address_type
    @address = Address.find(params[:id])
    @address_new = Address.new
    if @address.addressable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@address.addressable_id)
    else
      @organisation =Organisation.find(@address.addressable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      if @address.update_attributes(params[:address])
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for address with ID #{@address.id}.")
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @countries = Country.all
    @active_address = AddressType.active_address_type
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted address with ID #{@address.id}.")
    @address.destroy
    if @address.addressable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@address.addressable_id)
    else
      @organisation =Organisation.find(@address.addressable_id)  # if in organisation return organisation object to destroy.js
    end
    @address_new = Address.new
    respond_to do |format|
      format.js
    end
  end

  def search_postcodes
    @postcodes = Postcode.search_post_code(params[:suburb],params[:state], params[:postcode])
   
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
    @person = Person.find(@current_address.addressable_id)
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
    @person = Person.find(@up_current_address.addressable_id)

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

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @address = Address.new
    @person = Person.find_by_id(params[:params1])

    respond_to do |format|
      format.js
    end
  end

end
