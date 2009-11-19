class PostcodesController < ApplicationController
  # System Log stuff added

  def new
    @postcode = Postcode.new
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @postcode = Postcode.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @postcode = Postcode.new(params[:postcode])
    @postcode.country_id = session[:postcode_country_id]
    @postcode.country_name = Country.find(session[:postcode_country_id]).short_name unless session[:postcode_country_id].nil?
    @postcode.geo_area = GeographicalArea.find(params[:postcode][:geographical_area_id]).division_name unless params[:postcode][:geographical_area_id].nil?
    @postcode.elec_area = ElectoralArea.find(params[:postcode][:electoral_area_id]).division_name unless params[:postcode][:electoral_area_id].nil?
    if @postcode.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new postcode entry with ID #{@postcode.id}.")
    else
      
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @postcode = Postcode.find(params[:id])
    if @postcode.update_attributes(params[:postcode])
      @postcode.geo_area = GeographicalArea.find(params[:postcode][:geographical_area_id]).division_name unless params[:postcode][:geographical_area_id].nil?
      @postcode.elec_area = ElectoralArea.find(params[:postcode][:electoral_area_id]).division_name unless params[:postcode][:electoral_area_id].nil?
      @postcode.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for postcode with ID #{@postcode.id}.")
    end
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @postcode = Postcode.find(params[:id])
    @postcode.destroy
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted postcode with ID #{@postcode.id}.")
    respond_to do |format|
      format.js
    end
  end

  def show_by_country
    session[:postcode_country_id]= params[:param1]
    respond_to do |format|
      format.js
    end
  end

end
