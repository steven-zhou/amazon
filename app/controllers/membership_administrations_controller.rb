class MembershipAdministrationsController < ApplicationController

  def fee_items
      @type_class= "SubscriptionFeeItem"
    respond_to do |format|
      format.html
    end
  end
  
end
