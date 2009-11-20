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
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a country record.")
      #----------------------------presence - of----
      if(!@country.errors[:short_name].nil? && @country.errors.on(:short_name).include?("can't be blank"))
         flash.now[:error] = "Please Enter All Required Data"
      elsif(!@country.errors[:citizenship].nil? && @country.errors.on(:citizenship).include?("can't be blank"))
         flash.now[:error] = "Please Enter All Required Data"

        #-----------------------validate--uniqueness------------------------
      elsif(!@country.errors[:short_name].nil? && @country.errors.on(:short_name).include?("has already been taken"))
          flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "short_name")
      elsif(!@country.errors[:citizenship].nil? && @country.errors.on(:citizenship).include?("has already been taken"))
          flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "citizenship")
      end
    end
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
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a country record.")
      #----------------------------presence - of----
      if(!@country.errors[:short_name].nil? && @country.errors.on(:short_name).include?("can't be blank"))
         flash.now[:error] = "Please Enter All Required Data"
      elsif(!@country.errors[:citizenship].nil? && @country.errors.on(:citizenship).include?("can't be blank"))
         flash.now[:error] = "Please Enter All Required Data"

        #-----------------------validate--uniqueness------------------------
      elsif(!@country.errors[:short_name].nil? && @country.errors.on(:short_name).include?("has already been taken"))
          flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "short_name")
      elsif(!@country.errors[:citizenship].nil? && @country.errors.on(:citizenship).include?("has already been taken"))
          flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "citizenship")
      end
    end
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
        if (c.id.to_s == @previous_country.to_s)
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

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]

    respond_to do |format|
      format.js
    end
  end

end
