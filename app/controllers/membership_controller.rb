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



   def edit
    @membership = Membership.find(params[:id])
    @person = Person.find(@membership.person_id)
    respond_to do |format|
      format.js
    end
  end


   def update

   @membership = Membership.find(params[:id])
   @membership.update_attributes(params[:membership])

    respond_to do |format|
      format.js
    end
   end


  def review



    respond_to do |format|
      format.html
    end

  end






  def membership_person_lookup
    @membership = Membership.new
    @person = Person.find(params[:id]) rescue @person=nil

     respond_to do |format|
      format.js
    end
  end
  def membership_intiator_lookup

    @person = Person.find(params[:id]) rescue @person=nil
    @update_field = params[:update_field]
     respond_to do |format|
      format.js
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    respond_to do |format|
      format.js
    end
  end

end
