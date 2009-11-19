class CountriesController < ApplicationController
  # System Log stuff added

  def new
    @country = Country.new
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @country = Country.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @country = Country.new(params[:country])
    @country.govenment_language = Language.find(params[:country][:main_language_id].to_i).name unless params[:country][:main_language_id].blank?
    if @country.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new country entry with ID #{@country.id}.")
    else
      
    end
    @countries = Country.all
    respond_to do |format|
      format.js
    end
  end

  def update
    @country = Country.find(params[:id])
    @country.govenment_language = Language.find(params[:country][:main_language_id].to_i).name unless params[:country][:main_language_id].blank?
    if @country.update_attributes(params[:country])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for country with ID #{@country.id}.")
    else
      
    end
    @countries = Country.all
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @country = Country.find(params[:id])
    @country.destroy
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted country with ID #{@country.id}.")    
    respond_to do |format|
      format.js
    end
  end

  def select_renew
    @country = Country.find(:all,:order => 'short_name')
    @update_field = params[:param1]
    if params[:param1].to_s == "electoral_area"
      @previous_country = session[:ele_country_id]
    end
    
    unless @country.nil?
      country = String.new
      country += "<option></option>"
      for c in @country
        if (c.id == @previous_country)
          country += "<option value= '#{c.id}', selected >#{c.short_name}</option>"
        else
          country += "<option value= '#{c.id}'>#{c.short_name}</option>"
        end
      end
    end
    @country_new = country

    respond_to do |format|
      format.js
    end
  end

end
