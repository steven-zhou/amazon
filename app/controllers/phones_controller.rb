class PhonesController < ApplicationController

  before_filter :check_authentication
  
  def show
    @phone = Phone.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @entity = Person.find(params[:person_id].to_i) rescue Organisation.find(params[:organisation_id].to_i)
    @phone = @entity.phones.new(params[:phone])
    @phone.save
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @phone= Phone.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def update
    @phone = Phone.find(params[:id].to_i)
    respond_to do |format|
      if @phone.update_attributes(params[:phone])  
        format.js { render 'show.js' }
      end
    end
  end

  def destroy
    @phone = Phone.find(params[:id].to_i)
    @phone.destroy
    respond_to do |format|
      format.js
    end
  end

end
