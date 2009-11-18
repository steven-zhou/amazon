class PostAreasController < ApplicationController

  def select_ajax_show
    @postal_areas = (params[:type]).camelize.constantize.find_all_by_country_id(params[:param1])
    @country_id = params[:param1]
    session[:geo_country_id]= params[:param1]
    
    if (params[:type]== "GeographicalArea")
      @type = "geo_area"

    else
      @type = "ele_area"
   
    end
    respond_to do |format|
      format.js
    end
  end

  def new
    @postal_area = (params[:param1]).camelize.constantize.new
    if (params[:param1]== "GeographicalArea")
      @type = "geo_area"
    else
      @type = "ele_area"
    end
    respond_to do |format|
      format.js
    end
  end

  def create

    @postal_area = params[:type].camelize.constantize.new(params[params[:type].underscore.to_sym])
    if @postal_area.save
       system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new GeographicalArea with ID #{@postal_area.id}.")
     else

    end
     @postal_areas = (params[:type]).camelize.constantize.find_all_by_country_id(session[:geo_country_id])
    respond_to do |format|
      format.js
    end
    
  end

   


end
