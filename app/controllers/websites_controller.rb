class WebsitesController < ApplicationController
  
  def show
    @website = Website.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @person = Person.find(params[:person_id])
    @website = @person.websites.new(params[:website])
    @website.save
    respond_to do |format|
      format.js
    end
  end

  def edit
    @website = Website.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @website = Website.find(params[:id])
    respond_to do |format|
      if @website.update_attributes(params[:website])
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @website = Website.find(params[:id])
    @website.destroy
    respond_to do |format|
      format.js
    end
  end

end
