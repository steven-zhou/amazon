class WebsitesController < ApplicationController
  
  def show
    @website = Website.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
    @website = @entity.websites.new(params[:website])
    @website.save
    @person = Person.find(session[:user])
    respond_to do |format|
      format.js
    end
  end

  def edit
    @website = Website.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def update
    @website = Website.find(params[:id].to_i)
    respond_to do |format|
      if @website.update_attributes(params[:website])
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @website = Website.find(params[:id].to_i)
    @website.destroy
    @person = Person.find(session[:user])
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
    @person = Person.find(session[:user])
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
    @person = Person.find(session[:user])

    respond_to do |format|
      format.js
    end


  end

end
