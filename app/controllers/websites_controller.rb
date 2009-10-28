class WebsitesController < ApplicationController
  
  def show
    @website = Website.find(params[:id].to_i)
    @website_new = Website.new
    @person = Person.find(@website.contactable_id)
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
    @website = @entity.websites.new(params[:website])
    @website.save
    @person = Person.find(@website.contactable_id)

    if (params[:organisation_id])
      @organisation = Organisation.find(@website.contactable_id)
    end

    @website_new = Website.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @website = Website.find(params[:id].to_i)

    if @website.contactable_type == "Person"
      @person = Person.find(@website.contactable_id)   # if in Person return person object to destroy.js
    end
    if @website.contactable_type == "Organisation"
      @organisation =Organisation.find(@website.contactable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @website = Website.find(params[:id].to_i)
    @website_new = Website.new
     if @website.contactable_type == "Person"
      @person = Person.find(@website.contactable_id)   # if in Person return person object to destroy.js
    end
    if @website.contactable_type == "Organisation"
      @organisation =Organisation.find(@website.contactable_id)  # if in organisation return organisation object to destroy.js
    end
    respond_to do |format|
      if @website.update_attributes(params[:website])
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @website = Website.find(params[:id].to_i)
    @website.destroy
    @person = Person.find(@website.contactable_id)

    if @website.contactable_type == "Person"
      @person = Person.find(@website.contactable_id)   # if in Person return person object to destroy.js
    end
    if @website.contactable_type == "Organisation"
      @organisation =Organisation.find(@website.contactable_id)  # if in organisation return organisation object to destroy.js
    end

    @website_new = Website.new
    respond_to do |format|
      format.js
    end
  end


  def move_down_website_priority
    @current_website = Contact.find(params[:id])

    if(@current_website.priority_number==1)
      @exchange_website = @current_website.contactable.websites.find_by_priority_number(2)

      @exchange_website.priority_number = 1
      @current_website.priority_number = 2
      @exchange_website.save
      @current_website.save
    end
    @person = Person.find(@current_website.contactable_id)
    respond_to do |format|
      format.js
    end

  end

  def move_up_website_priority
    @up_current_website = Contact.find(params[:id])
    @up_exchange_website = @up_current_website.contactable.websites.find_by_priority_number(@up_current_website.priority_number - 1)

    @up_exchange_website.priority_number = @up_exchange_website.priority_number + 1
    @up_current_website.priority_number = @up_current_website.priority_number - 1

    @up_exchange_website.save
    @up_current_website.save
    @person = Person.find(@up_current_website)

    respond_to do |format|
      format.js
    end


  end

  def move_organisation_down_website_priority
    @current_website = Contact.find(params[:id])

    if(@current_website.priority_number==1)
      @exchange_website = @current_website.contactable.websites.find_by_priority_number(2)

      @exchange_website.priority_number = 1
      @current_website.priority_number = 2
      @exchange_website.save
      @current_website.save
    end
    @organisation = Organisation.find(@current_website.contactable_id)
    respond_to do |format|
      format.js
    end

  end

  def move_organisation_up_website_priority
    @up_current_website = Contact.find(params[:id])
    @up_exchange_website =  @up_current_website.contactable.websites.find_by_priority_number( @up_current_website.priority_number - 1)

    @up_exchange_website.priority_number = @up_exchange_website.priority_number + 1
    @up_current_website.priority_number =  @up_current_website.priority_number - 1

    @up_exchange_website.save
    @up_current_website.save
    @organisation = Organisation.find( @up_current_website.contactable_id)

    respond_to do |format|
      format.js
    end

  end
end
