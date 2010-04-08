class EmailsController < ApplicationController
  # System Logging added...


  def show
    @email = Email.find(params[:id])
    @email_new = Email.new
    if @email.contactable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@email.contactable_id)
    else
      @organisation =Organisation.find(@email.contactable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)   
    @email = @entity.emails.new(params[:email])
    @email.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Email with ID #{@email.id}.")
    if @email.contactable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@email.contactable_id)
      @person.primary_email_address = @person.emails.find_by_priority_number(1).value
      @person.save
    else
      @organisation =Organisation.find(@email.contactable_id)  # if in organisation return organisation object to destroy.js
      @organisation.primary_email_address = @organisation.emails.find_by_priority_number(1).value
      @organisation.save
    end
    @email_new = Email.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @email = Email.find(params[:id])
    if @email.contactable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@email.contactable_id)
    else
      @organisation =Organisation.find(@email.contactable_id)  # if in organisation return organisation object to destroy.js
    end

    @email_new = Email.new
    respond_to do |format|
      format.js
    end
  end

  def update
    @email = Email.find(params[:id].to_i)
    @email_new = Email.new
    if @email.contactable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@email.contactable_id)
    else
      @organisation =Organisation.find(@email.contactable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      if @email.update_attributes(params[:email])
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) edited Email with ID #{@email.id}.")
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @email = Email.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Email with ID #{@email.id}.")
    @email.destroy

    @email_new = Email.new
    if @email.contactable_type == "Person"             # if in Person return person object to destroy.js
      @person = Person.find(@email.contactable_id)
      @person.primary_email_address =  @person.emails.find_by_priority_number(1).value rescue @person.primary_email_address = nil
      @person.save
    else
      @organisation =Organisation.find(@email.contactable_id)  # if in organisation return organisation object to destroy.js
      @organisation.primary_email_address =  @organisation.emails.find_by_priority_number(1).value rescue @organisation.primary_email_address = nil
      @organisation.save
    end
    respond_to do |format|
      format.js
    end
  end

  def move_down_email_priority
    @current_email = Contact.find(params[:id])

    if(@current_email.priority_number==1)
      @exchange_email = @current_email.contactable.emails.find_by_priority_number(2)

      @exchange_email.priority_number = 1
      @current_email.priority_number = 2
      @exchange_email.save
      @current_email.save
    end
    @person = Person.find(@current_email.contactable_id)
    @person.primary_email_address = @person.emails.find_by_priority_number(1).value
    @person.save
    respond_to do |format|
      format.js
    end
  end

  def move_up_email_priority
    @up_current_email = Contact.find(params[:id])
    @up_exchange_email = @up_current_email.contactable.emails.find_by_priority_number(@up_current_email.priority_number - 1)

    @up_exchange_email.priority_number = @up_exchange_email.priority_number + 1
    @up_current_email.priority_number = @up_current_email.priority_number - 1

    @up_exchange_email.save
    @up_current_email.save
    @person = Person.find(@up_current_email.contactable_id)
    @person.primary_email_address = @person.emails.find_by_priority_number(1).value
    @person.save

    respond_to do |format|
      format.js
    end

  end

  def move_organisation_down_email_priority
    @current_email = Contact.find(params[:id])

    if(@current_email.priority_number==1)
      @exchange_email = @current_email.contactable.emails.find_by_priority_number(2)

      @exchange_email.priority_number = 1
      @current_email.priority_number = 2
      @exchange_email.save
      @current_email.save
    end
    @organisation = Organisation.find(@current_email.contactable_id)
    @organisation.primary_email_address = @organisation.emails.find_by_priority_number(1).value
    @organisation.save
    respond_to do |format|
      format.js
    end
  end

  def move_organisation_up_email_priority
    @up_current_email = Contact.find(params[:id])
    @up_exchange_email = @up_current_email.contactable.emails.find_by_priority_number(@up_current_email.priority_number - 1)

    @up_exchange_email.priority_number = @up_exchange_email.priority_number + 1
    @up_current_email.priority_number = @up_current_email.priority_number - 1

    @up_exchange_email.save
    @up_current_email.save
    @organisation = Organisation.find(@up_current_email.contactable_id)
    @organisation.primary_email_address = @organisation.emails.find_by_priority_number(1).value
    @organisation.save
    respond_to do |format|
      format.js
    end
  end

end
