class MembershipController < ApplicationController


  def new

    @membership = Membership.new


    respond_to do |format|
      format.html
    end
  end


  def membership_person_lookup
    
    @person = Person.find(params[:id])

     respond_to do |format|
      format.js
    end
  end


    def membership_organisation_lookup

    @organisation = Organisation.find(params[:id])

     respond_to do |format|
      format.js
    end
  end

end
