class MembershipController < ApplicationController


  def new

    @membership = Membership.new


    respond_to do |format|
      format.html
    end
  end

end
