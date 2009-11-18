class PostAreasController < ApplicationController

  def select_ajax_show
    @postal_areas = (params[:type]).camelize.constantize.find_all_by_country_id(params[:param1])
    if (params[:type]== "GeographicalArea")
      @type = "geo_area"
    
    else
      @type = "ele_area"
   
    end
    respond_to do |format|
      format.js
    end
  end


end
