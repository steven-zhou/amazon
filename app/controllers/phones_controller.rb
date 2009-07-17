class PhonesController < ApplicationController
  
  def show
    @phone = Phone.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @person = Person.find(params[:person_id])
    @phone = @person.phones.new(params[:phone])
    @phone.save
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @phone= Phone.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @phone = Phone.find(params[:id])
    respond_to do |format|
      if @phone.update_attributes(params[:phone])  
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @phone = Phone.find(params[:id])
    @phone.destroy
    respond_to do |format|
      format.js
    end
  end

end
