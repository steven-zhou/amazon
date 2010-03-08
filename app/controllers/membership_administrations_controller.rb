class MembershipAdministrationsController < ApplicationController

  def fee_items
      @type_class= "MembershipFeeItem"
    respond_to do |format|
      format.html
    end
  end
  
end
