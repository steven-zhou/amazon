class MembershipFeesController < ApplicationController
  # System Log stuff added

  def new
    @membership_fee = MembershipFee.new
    respond_to do |format|
      format.js
    end
  end

end
