class PortalController < ApplicationController

  layout nil
  protect_from_forgery :only => [:create, :update, :destroy]
  before_filter :check_authentication, :except => [:sign_up_form, :sign_up]

  def sign_up_form
    @potential_member = PotentialMember.new
    respond_to do |format|
      format.html
    end
  end

  def sign_up
    @potential_member = PotentialMember.new(params[:potential_member])
    if @potential_member.save
      render 'sign_up'
    else
      flash[:error] = ""
      flash[:error] += "First Name can't be blank <br/>" if (!@potential_member.errors.on(:first_name).nil? && @potential_member.errors.on(:first_name).include?("can't be blank"))
      flash[:error] += "Family Name can't be blank <br/>" if (!@potential_member.errors.on(:family_name).nil? && @potential_member.errors.on(:family_name).include?("can't be blank"))
      flash[:error] += "Email can't be blank <br/>" if (!@potential_member.errors.on(:email).nil? && @potential_member.errors.on(:email).include?("can't be blank"))
      flash[:error] += "Email is already existing <br/>" if (!@potential_member.errors.on(:email).nil? && @potential_member.errors.on(:email).include?("has already been taken"))
      render 'sign_up_form'
    end
  end

end
