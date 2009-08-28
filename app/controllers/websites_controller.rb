class WebsitesController < ApplicationController

  before_filter :check_authentication
  
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
    respond_to do |format|
      format.js
    end
  end

end
