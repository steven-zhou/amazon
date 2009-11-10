class ImagesController < ApplicationController
  caches_page :show

  def show
    @image = Image.find(params[:id])
    respond_to do |format|
      format.jpg 
    end
  end

  def edit
    @image = Image.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
    @image = @entity.image.new(params[:image])
    @image.save
    respond_to do |format|
      format.js
    end
  end

  def update
    @image = Image.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
     @entity = Person.find(@image.imageable.id) rescue Organisation.find(@image.imageable.id)
    @image.destroy
    respond_to do |format|
      format.js
    end
  end

  def thumb
    @image = Image.find(params[:id])
    render :inline => "@image.operate {|i| i.resize '61x61'}", :type => :flexi
  end

  def thumb_large
    @image = Image.find(params[:id])
    render :inline => "@image.operate {|i| i.resize '91x91'}", :type => :flexi
  end
  
end