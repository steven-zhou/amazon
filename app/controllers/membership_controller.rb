class MembershipController < ApplicationController


  def new

    @membership = Membership.new


    respond_to do |format|
      format.html
    end
  end


  def create

    @membership = Membership.new(params[:membership])
    @membership.save!
   unless @membership.save!

     flash[:error] = "Can not save the Membership Data"
   end
    respond_to do |format|
      format.js
    end
  end


  def membership_person_lookup
    @membership = Membership.new
    @person = Person.find(params[:id]) rescue @person=nil

     respond_to do |format|
      format.js
    end
  end


end
