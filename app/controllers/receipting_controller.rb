class ReceiptingController < ApplicationController
  

  def campaign_data


  end

  def new_campaign
    @campaign = Campaign.new
    respond_to do |format|
      format.js
    end
  end

  def create_campaign
    @campaign = Campaign.new(params[:campaign])
    @campaign.start_date = params[:start_date]
    @campaign.end_date = params[:end_date]
    if @campaign.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new campaign entry with ID #{@campaign.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a campaign record.")
      if(!@campaign.errors[:start_date].nil?)
         flash.now[:error] = "Please Enter A Start Date"
      elsif(!@campaign.errors[:name].nil?)
         flash.now[:error] = "Please Enter A Name"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def update_campaign
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(params[:campaign])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated a new campaign entry with ID #{@campaign.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a campaign #{@campaign.id}.")
      if(!@campaign.errors[:start_date].nil?)
         flash.now[:error] = "Please Enter A Start Date"
      elsif(!@campaign.errors[:name].nil?)
         flash.now[:error] = "Please Enter A Name"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def edit_campaign
    @campaign = Campaign.find(params[:id])
    respond_to do |format|
      format.js
    end
  end


  def show_by_campaign
    session[:source_campaign_id] = params[:param1]
    # puts "***** DEBUG Setting session[:source_campaign_id] to #{params[:param1]} "
    respond_to do |format|
      format.js
    end
  end

  def new_source
    @source = Source.new
    respond_to do |format|
      format.js
    end
  end

  def create_source
    @source = Source.new(params[:source])
    @source.campaign_id = params[:id]
    if @source.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new campaing source with ID #{@source.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a campaign source record.")
      if(!@source.errors[:campaign_id].nil?)
         flash.now[:error] = "You must select a campaign for this source."
      elsif(!@source.errors[:name].nil?)
         flash.now[:error] = "A source with that name already exists for this campaign. Names must be unique."
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def edit_source
    @source = Source.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update_source
    @source = Source.find(params[:id])
    if @source.update_attributes(params[:source])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for source with ID #{@source.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update source record #{@source.id}.")
      if(!@source.errors[:campaign_id].nil?)
         flash.now[:error] = "You must select a campaign for this source."
      elsif(!@source.errors[:name].nil?)
         flash.now[:error] = "A source with that name already exists for this campaign. Names must be unique."
      end
    end
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
