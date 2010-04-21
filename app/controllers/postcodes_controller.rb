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
    #    @postcode.country_name = Country.find(session[:postcode_country_id]).short_name unless session[:postcode_country_id].blank?
    #    @postcode.geo_area = GeographicalArea.find(params[:postcode][:geographical_area_id]).division_name unless params[:postcode][:geographical_area_id].blank?
    #    @postcode.elec_area = ElectoralArea.find(params[:postcode][:electoral_area_id]).division_name unless params[:postcode][:electoral_area_id].blank?
    if @postcode.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new postcode entry with ID #{@postcode.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a postcode record.")
      #----------------------------presence - of----
      # the validation of :geographical_area_id & :electoral_area_id are actually not usefull
      if(!@postcode.errors[:postcode].nil? && @postcode.errors.on(:postcode).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@postcode.errors[:state].nil? && @postcode.errors.on(:state).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@postcode.errors[:suburb].nil? && @postcode.errors.on(:suburb).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@postcode.errors[:geographical_area_id].nil? && @postcode.errors.on(:geographical_area_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@postcode.errors[:electoral_area_id].nil? && @postcode.errors.on(:electoral_area_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"

        #-----------------------uniqueness - of ------------------------
      elsif(!@postcode.errors[:postcode].nil? && @postcode.errors.on(:postcode).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "postcode")
      elsif(!@postcode.errors[:suburb].nil? && @postcode.errors.on(:suburb).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "suburb")
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @postcode = Postcode.find(params[:id])
    if @postcode.update_attributes(params[:postcode])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for postcode with ID #{@postcode.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a postcode record.")
      #----------------------------presence - of----
      if(!@postcode.errors[:postcode].nil? && @postcode.errors.on(:postcode).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@postcode.errors[:state].nil? && @postcode.errors.on(:state).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@postcode.errors[:suburb].nil? && @postcode.errors.on(:suburb).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@postcode.errors[:geographical_area_id].nil? && @postcode.errors.on(:geographical_area_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@postcode.errors[:electoral_area_id].nil? && @postcode.errors.on(:electoral_area_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"

        #-----------------------uniqueness - of ------------------------
      elsif(!@postcode.errors[:postcode].nil? && @postcode.errors.on(:postcode).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "postcode")
      elsif(!@postcode.errors[:suburb].nil? && @postcode.errors.on(:suburb).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "suburb")
      end
    end
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @postcode = Postcode.find(params[:id])
    #    @postcode.destroy
    @postcode.to_be_removed = true
    @postcode.save
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

  def lookup_postcode
    unless params[:country].blank?
      @postcode = Postcode.lookup_postcode(params[:suburb],params[:state],params[:country]) rescue @postcode = nil
    else
      @postcode = Postcode.lookup_postcode(params[:suburb],params[:state]) rescue @postcode = nil
    end
    @postcode_id = @postcode.try(:postcode)
    @postcode_country_name = @postcode.try(:country).try(:short_name)


    if @postcode_id.nil? || @postcode_country_name.nil?
      flash.now[:error]= "Can not Find the Suburb or State.</br> Do you want to continue ?"
    end
    respond_to do |format|
      format.js
    end
  end

  def retrieve_postcode
    @postcode = Postcode.find(params[:id])
    #    @postcode.destroy
    @postcode.to_be_removed = false
    @postcode.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) retrieved postcode with ID #{@postcode.id}.")
    respond_to do |format|
      format.js
    end
  end

end
