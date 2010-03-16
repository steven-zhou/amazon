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
    @membership = Membership.find(params[:membership_fee][:membership_id])
    if @membership_fee.save
      @membership.update_attribute("membership_status_id", MembershipStatus.approve.id) if @membership.membership_status_id != MembershipStatus.approve.id
      @membership_log = @membership.membership_logs.last
      @membership_log.update_attribute("post_status", MembershipStatus.approve.name)
    else

    end
    @membership_id = @membership.id
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
