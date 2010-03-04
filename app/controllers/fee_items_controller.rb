class FeeItemsController < ApplicationController
  # System Log stuff added

  def new
    @fee_item = (params[:param1]).camelize.constantize.new
    if (params[:param1]== "SubscriptionFeeItem")
      @type = "subscription_fee"
    else
      @type = "membership_fee"
    end
    respond_to do |format|
      format.js
    end
  end

  def create

    respond_to do |format|
      format.js
    end
  end

  def edit

    respond_to do |format|
      format.js
    end
  end

  def update

    respond_to do |format|
      format.js
    end
  end

  def destroy

    respond_to do |format|
      format.js
    end
  end

  def retrieve

    respond_to do |format|
      format.js
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
#    if @field == "person_part"
#      @list_headers = @current_user.all_person_lists
#    else
#      @org_lists = @current_user.all_organisation_lists
#    end
    respond_to do |format|
      format.js
    end
  end
end
