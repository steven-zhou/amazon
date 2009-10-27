class PhonesController < ApplicationController
  
  def show
    @phone = Phone.find(params[:id].to_i)
      @person = Person.find(session[:user])
     @phone_new = Phone.new
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)


    
    @phone = @entity.phones.new(params[:phone])
    @phone.save
    @person = Person.find(session[:user])
    @phone_new = Phone.new
    if (params[:organisation_id])
      @organisation = Organisation.find(@phone.contactable_id)
    end



    
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @phone= Phone.find(params[:id].to_i)
    @person = Person.find(session[:user])
 
    respond_to do |format|
      format.js
    end
  end

  def update
    @phone = Phone.find(params[:id].to_i)
    @person = Person.find(session[:user])
     @phone_new = Phone.new
    respond_to do |format|
      if @phone.update_attributes(params[:phone])  
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
   
    @phone = Phone.find(params[:id].to_i)
    @phone.destroy

    #     if @address.addressable_type == "Person"             # if in Person return person object to destroy.js
    #      @current_object = Person.find(session[:user])
    #    end
    #    if @address.addressable_type == "Organisation"
    #      @current_object =Organisation.find(@address.addressable_id)  # if in organisation return organisation object to destroy.js
    #    end

    if @phone.contactable_type == "Person"
      @person = Person.find(session[:user])   # if in Person return person object to destroy.js
    end
    if @phone.contactable_type == "Organisation"
      @organisation =Organisation.find(@phone.contactable_id)  # if in organisation return organisation object to destroy.js
    end

      @phone_new = Phone.new
    respond_to do |format|
      format.js
    end
  end


  def move_down_phone_priority
    @current_phone = Contact.find(params[:id])

    if(@current_phone.priority_number==1)
      @exchange_phone = @current_phone.contactable.phones.find_by_priority_number(2)

      @exchange_phone.priority_number = 1
      @current_phone.priority_number = 2
      @exchange_phone.save
      @current_phone.save
    end
    @person = Person.find(session[:user])
    respond_to do |format|
      format.js
    end

  end


  def move_up_phone_priority
    @up_current_phone = Contact.find(params[:id])
    @up_exchange_phone = @up_current_phone.contactable.phones.find_by_priority_number(@up_current_phone.priority_number - 1)

    @up_exchange_phone.priority_number = @up_exchange_phone.priority_number + 1
    @up_current_phone.priority_number = @up_current_phone.priority_number - 1

    @up_exchange_phone.save
    @up_current_phone.save
    @person = Person.find(session[:user])

    respond_to do |format|
      format.js
    end

  end


  def move_organisation_down_phone_priority

    @current_phone = Contact.find(params[:id])

    if(@current_phone.priority_number==1)
      @exchange_phone = @current_phone.contactable.phones.find_by_priority_number(2)

      @exchange_phone.priority_number = 1
      @current_phone.priority_number = 2
      @exchange_phone.save
      @current_phone.save
    end
    @organisation = Organisation.find(@current_phone.contactable_id)
    respond_to do |format|
      format.js
    end
  end

  def move_organisation_up_phone_priority
    @up_current_phone = Contact.find(params[:id])
    @up_exchange_phone = @up_current_phone.contactable.phones.find_by_priority_number(@up_current_phone.priority_number - 1)

    @up_exchange_phone.priority_number = @up_exchange_phone.priority_number + 1
    @up_current_phone.priority_number = @up_current_phone.priority_number - 1

    @up_exchange_phone.save
    @up_current_phone.save
    @organisation = Organisation.find(@up_current_phone.contactable_id)

    respond_to do |format|
      format.js
    end
  end
end
