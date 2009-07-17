class PhotosController < ApplicationController
  def update
    @person = Person.find(params[:person_id])
    @person.update_attributes(params[:person])
    @person.save!
    render :layout => false
  end

  def destroy
    @person = Person.find(params[:person_id])
    @person.photo.clear
    @person.save!
    render :layout => false
  end
end