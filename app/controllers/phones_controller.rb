class PhonesController < ApplicationController
  # System log done
  
  def show
    @phone = Phone.find(params[:id].to_i)
    @phone_new = Phone.new
    if @phone.contactable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@phone.contactable_id)
    else
      @organisation =Organisation.find(@phone.contactable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)

    @phone = @entity.phones.new(params[:phone])
    @phone.save
    
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Phone ID #{@phone.id}.")
    if @phone.contactable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@phone.contactable_id)
      @person.primary_phone_num = @person.phones.find_by_priority_number(1).value
      @person.save
    else
      @organisation =Organisation.find(@phone.contactable_id)  # if in organisation return organisation object to destroy.js
      @organisation.primary_phone_num = @organisation.phones.find_by_priority_number(1).value
      @organisation.save
    end
    @phone_new = Phone.new
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @phone =Phone.find(params[:id].to_i) 
    @person = Person.find(@phone.contactable_id)
    if @phone.contactable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@phone.contactable_id)
    else
      @organisation =Organisation.find(@phone.contactable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @phone = Phone.find(params[:id].to_i)
   
    @phone_new = Phone.new
    if @phone.update_attributes(params[:phone])
      if @phone.contactable_type == "Person"             # if in Person return person object to destroy.js
        @person = Person.find(@phone.contactable_id)
        @person.primary_phone_num = @person.phones.find_by_priority_number(1).value
        @person.save
      else
        @organisation =Organisation.find(@phone.contactable_id)  # if in organisation return organisation object to destroy.js
        @organisation.primary_phone_num = @organisation.phones.find_by_priority_number(1).value
        @organisation.save
      end
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Phone #{@phone.id}.")

    end
    respond_to do |format|

      format.js { render 'show.js' }
    end
  end

  def destroy
   
    @phone = Phone.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Phone #{@phone.id}.")
    @phone.destroy

    #     if @address.addressable_type == "Person"             # if in Person return person object to destroy.js
    #      @current_object = Person.find(session[:user])
    #    end
    #    if @address.addressable_type == "Organisation"
    #      @current_object =Organisation.find(@address.addressable_id)  # if in organisation return organisation object to destroy.js
    #    end

    if @phone.contactable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@phone.contactable_id)
      @person.primary_phone_num =  @person.phones.find_by_priority_number(1).value rescue @person.primary_phone_num = nil
      @person.save
    else
      @organisation =Organisation.find(@phone.contactable_id)  # if in organisation return organisation object to destroy.js
      @organisation.primary_phone_num =  @organisation.phones.find_by_priority_number(1).value rescue @organisation.primary_phone_num = nil
      @organisation.save
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
    @person = Person.find(@current_phone.contactable_id)
    @person.primary_phone_num = @person.phones.find_by_priority_number(1).value
    @person.save
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
    @person = Person.find(@up_current_phone.contactable_id)
    @person.primary_phone_num = @person.phones.find_by_priority_number(1).value
    @person.save
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
    @organisation.primary_phone_num = @organisation.phones.find_by_priority_number(1).value
    @organisation.save
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
    @organisation.primary_phone_num = @organisation.phones.find_by_priority_number(1).value
    @organisation.save
    respond_to do |format|
      format.js
    end
  end
end
