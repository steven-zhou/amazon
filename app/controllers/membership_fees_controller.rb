class MembershipFeesController < ApplicationController
  # System Log stuff added

  def new
    @membership_fee = MembershipFee.new
    respond_to do |format|
      format.js
    end
  end

    def destroy
    membership_fee = MembershipFee.find(params[:id])
    @membership_id = membership_fee.try(:membership_id)
    membership_fee.destroy
     respond_to do |format|
      format.js
    end

  end
end
