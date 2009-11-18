class PostcodesController < ApplicationController
  # System Log stuff added

  def edit
    @postcode = Postcode.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @postcode = Postcode.new(params[:postcode])
    if @postcode.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new postcode entry with ID #{@postcode.id}.")
    else
      
    end
    @postcodes = Postcode.find(:all, :conditions => ["country_id = ?", params[:country_id]], :order => "postcode ASC")
    respond_to do |format|
      format.js
    end
  end

  def update
    @postcode = Postcode.find(params[:id])
    if @postcode.update_attributes(params[:postcode])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for postcode with ID #{@postcode.id}.")
    end
    @postcodes = Postcode.find(:all, :conditions => ["country_id = ?", params[:country_id]], :order => "postcode ASC")
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @postcode = Postcode.find(params[:id])
    @postcode.destroy
    @postcodes = Postcode.find(:all, :conditions => ["country_id = ?", params[:country_id]], :order => "postcode ASC")
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted postcode with ID #{@postcode.id}.")
    respond_to do |format|
      format.js
    end
  end

end
