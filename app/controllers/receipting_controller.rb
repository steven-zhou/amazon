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


  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]

    respond_to do |format|
      format.js
    end
  end

end
