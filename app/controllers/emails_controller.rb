class EmailsController < ApplicationController

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
    @person = Person.find(session[:user])
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
    @person = Person.find(session[:user])
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
    @person = Person.find(session[:user])
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
    @person = Person.find(session[:user])

    respond_to do |format|
      format.js
    end

 end

end
