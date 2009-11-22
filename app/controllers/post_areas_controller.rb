class PostAreasController < ApplicationController

  def select_ajax_show
    @postal_areas = (params[:type]).camelize.constantize.find_all_by_country_id(params[:param1])
    @country_id = params[:param1]
    session[:geo_country_id]= params[:param1]
    session[:ele_country_id]= params[:param1]
    if (params[:type]== "GeographicalArea")
      @type = "geo_area"
    else
      @type = "electoral_area"
    end
    respond_to do |format|
      format.js
    end
  end

  def new
    @postal_area = (params[:param1]).camelize.constantize.new
    @country_name = Country.find_by_id(session[:geo_country_id]).short_name
    if (params[:param1]== "GeographicalArea")
      @type = "geo_area"
    else
      @type = "electoral_area"
    end
    respond_to do |format|
      format.js
    end
  end

  def create
    @postal_area = params[:type].camelize.constantize.new(params[params[:type].underscore.to_sym])
    if @postal_area.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new #{@postal_area.class.to_s} with ID #{@postal_area.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new #{@postal_area.class.to_s}")
      #----------------------------presence - of--------------
      if(!@postal_area.errors[:division_name].nil? && @postal_area.errors.on(:division_name).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
        #-----------------------validate--uniqueness------------------------
      elsif(!@postal_area.errors[:division_name].nil? && @postal_area.errors.on(:division_name).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "division_name")  
      else
        flash.now[:error] = "Input Error"
      end
    end
    @country_id = session[:geo_country_id]
    @country_id_ele = session[:ele_country_id]
    if (@postal_area.class.to_s == "GeographicalArea")
      @type = "geo_area"
    else
      @type = "electoral_area"
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    @postal_area = params[:type].camelize.constantize.find(params[:id])
    if (params[:type]== "GeographicalArea")
      @type = "geo_area"
    else
      @type = "electoral_area"
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @postal_area = PostArea.find(params[:id].to_i)    
    if @postal_area.update_attributes(params[params[:type].underscore.to_sym])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated #{params[:type]} Setting with ID #{ @postal_area.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update #{params[:type]} Setting with ID #{ @postal_area.id}.")
      #----------------------------presence - of--------------
      if(!@postal_area.errors[:division_name].nil? && @postal_area.errors.on(:division_name).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
        #-----------------------validate--uniqueness------------------------
      elsif(!@postal_area.errors[:division_name].nil? && @postal_area.errors.on(:division_name).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "division_name")
      else
        flash.now[:error] = "Input Error"
      end

    end
    @country_id = session[:geo_country_id]
    @country_id_ele = session[:ele_country_id]
    if (params[:type]== "GeographicalArea")
      @type = "geo_area"
    else
      @type = "electoral_area"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @postal_area = PostArea.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted #{@postal_area.class.to_s} ID #{@postal_area.id}.")
    @postal_area.destroy
    respond_to do |format|
      format.js
    end
  end

end
