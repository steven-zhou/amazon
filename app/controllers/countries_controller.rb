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

end
