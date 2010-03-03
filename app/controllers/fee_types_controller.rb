class FeeTypesController < ApplicationController
  # System Log stuff added

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    if @field == "subscription_page"
      @tag_meta_types = SubscriptionFeeMetaMetaType.all
      @category = "SubscriptionFee"
    else
      @tag_meta_types = MembershipFeeMetaMetaType.all
      @category = "SubscriptionFee"
    end
    respond_to do |format|
      format.js
    end
  end
end
