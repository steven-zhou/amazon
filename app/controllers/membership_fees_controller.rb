class MembershipFeesController < ApplicationController
  # System Log stuff added

  def new
    @membership_fee = MembershipFee.new
    @membership = Membership.find(params[:param1])
    respond_to do |format|
      format.js
    end
  end

  def create
    @membership_fee = MembershipFee.new(params[:membership_fee])
    @membership_fee.save
    @membership_id =params[:membership_fee][:membership_id]
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
