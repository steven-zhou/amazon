class GuestsController < ApplicationController

  layout nil
  before_filter :check_authentication, :except => [:index,:new,:create,:login]

  def index

  end

  #--comment when you click the register button for guest register process
  def new
    @guest = SystemUser.new
    respond_to do |format|
      format.js
    end
  end


  def create

    @guest = Guest.new(params[:guest])
    #----comment use the password setter method , set it as system random generate password
    @guest.password = Guest.generate_password
    if @guest.save



    else

      #----------------------------presence - of------------------------#
      if (!@guest.errors[:email].nil? && @guest.errors.on(:email).include?("can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "email")
      elsif(!@guest.errors[:first_name].nil? && @guest.errors.on(:first_name).include?("can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "first_name")
      elsif(!@guest.errors[:family_name].nil? && @guest.errors.on(:family_name).include?("can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "family_name")
      elsif(!@guest.errors[:phone_num].nil? && @guest.errors.on(:phone_num).include?("can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "phone_num")

        #-----------------------validate--presence of ------------------------
      elsif(!@guest.errors[:email].nil? && @guest.errors.on(:email).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "email") 
      else
        flash.now[:error] = flash_message(:message => "Please Check Your Input, There are some invalid input")
      end
    end
    render :action=>"index"
  end



  def login

    if Guest.authenticate(params[:user_name],params[:password])
     
      render :action=>"index"
    else
      render "login.rhtml"
    end

  end
end
