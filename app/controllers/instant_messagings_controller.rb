class InstantMessagingsController < ApplicationController

    def show
    @instant_messaging = InstantMessaging.find(params[:id].to_i)
    @instant_messaging_new = InstantMessaging.new
    if @instant_messaging.contactable_type == "Person"
      @person = Person.find(@instant_messaging.contactable_id)   # if in Person return person object to destroy.js
    else
      @organisation =Organisation.find(@instant_messaging.contactable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      format.js
    end
  end

    def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
    @instant_messaging = @entity.instant_messagings.new(params[:instant_messaging])
    @instant_messaging.save
    if @instant_messaging.contactable_type == "Person"
      @person = Person.find(@instant_messaging.contactable_id)   # if in Person return person object to destroy.js
    else
      @organisation =Organisation.find(@instant_messaging.contactable_id)  # if in organisation return organisation object to destroy.js
    end

    @instant_messaging_new = InstantMessaging.new
    respond_to do |format|
      format.js
    end
  end

  def update
@instant_messaging = InstantMessaging.find(params[:id].to_i)
        @instant_messaging_new = InstantMessaging.new
    if @instant_messaging.contactable_type == "Person"
      @person = Person.find(@instant_messaging.contactable_id)   # if in Person return person object to destroy.js
    else
      @organisation =Organisation.find(@instant_messaging.contactable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      if @instant_messaging.update_attributes(params[:instant_messaging])
        format.js { render 'show.js' }
      end
    end
  end


     def edit
     @instant_messaging = InstantMessaging.find(params[:id].to_i)
    if  @instant_messaging.contactable_type == "Person"
      @person = Person.find( @instant_messaging.contactable_id)   # if in Person return person object to destroy.js
    else
      @organisation =Organisation.find( @instant_messaging.contactable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      format.js
    end
  end

      def destroy
         @instant_messaging = InstantMessaging.find(params[:id].to_i)
    @instant_messaging.destroy
    if @instant_messaging.contactable_type == "Person"
      @person = Person.find(@instant_messaging.contactable_id)   # if in Person return person object to destroy.js
    else
      @organisation =Organisation.find(@instant_messaging.contactable_id)  # if in organisation return organisation object to destroy.js
    end
    @instant_messaging_new = InstantMessaging.new
    respond_to do |format|
      format.js
    end
  end


    def move_down_instant_messaging_priority
    @current_instant_messaging = Contact.find(params[:id])
    if(@current_instant_messaging.priority_number==1)
      @exchange_instant_messaging = @current_instant_messaging.contactable.instant_messagings.find_by_priority_number(2)
      @exchange_instant_messaging.priority_number = 1
      @current_instant_messaging.priority_number = 2
      @exchange_instant_messaging.save
      @current_instant_messaging.save
    end
    @person = Person.find(@current_instant_messaging.contactable_id)
    respond_to do |format|
      format.js
    end
  end

  def move_up_instant_messaging_priority
    @up_current_instant_messaging = Contact.find(params[:id])
    @up_exchange_instant_messaging = @up_current_instant_messaging.contactable.instant_messagings.find_by_priority_number(@up_current_instant_messaging.priority_number - 1)
    @up_exchange_instant_messaging.priority_number = @up_exchange_instant_messaging.priority_number + 1
    @up_current_instant_messaging.priority_number = @up_current_instant_messaging.priority_number - 1
    @up_exchange_instant_messaging.save
    @up_current_instant_messaging.save
    @person = Person.find(@up_current_instant_messaging.contactable_id)
    respond_to do |format|
      format.js
    end


  end

  def move_organisation_down_instant_messaging_priority
    @current_instant_messaging = Contact.find(params[:id])

    if(@current_instant_messaging.priority_number==1)
      @exchange_instant_messaging = @current_instant_messaging.contactable.instant_messagings.find_by_priority_number(2)

      @exchange_instant_messaging.priority_number = 1
      @current_instant_messaging.priority_number = 2
      @exchange_instant_messaging.save
      @current_instant_messaging.save
    end
    @organisation = Organisation.find(@current_instant_messaging.contactable_id)
    respond_to do |format|
      format.js
    end

  end

  def move_organisation_up_instant_messaging_priority
    @up_current_instant_messaging = Contact.find(params[:id])
    @up_exchange_instant_messaging =  @up_current_instant_messaging.contactable.instant_messagings.find_by_priority_number( @up_current_instant_messaging.priority_number - 1)

    @up_exchange_instant_messaging.priority_number = @up_exchange_instant_messaging.priority_number + 1
    @up_current_instant_messaging.priority_number =  @up_current_instant_messaging.priority_number - 1

    @up_exchange_instant_messaging.save
    @up_current_instant_messaging.save
    @organisation = Organisation.find( @up_current_instant_messaging.contactable_id)

    respond_to do |format|
      format.js
    end

  end
end
