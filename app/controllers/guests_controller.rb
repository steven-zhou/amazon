class GuestsController < ApplicationController

  layout nil
  include SimpleCaptcha::ControllerHelpers
  before_filter :check_authentication, :except => [:index,:new,:create,:login,:captcha,:reset]

  def index


    #    respond_to do |format|
    #      format.js
    #    end
  end

  #--comment when you click the register button for guest register process
  def new
    @guest = SystemUser.new
    respond_to do |format|
      format.js
    end
  end


  def create

    @guest = Guest.new(params[:guests])
    #----comment use the password setter method , set it as system random generate password
    @guest.password = Guest.generate_password
    @guest.password_by_system = true


    if simple_captcha_valid? and @guest.save

      email = EmailDispatcher.create_send_guest_username_and_password(@guest)

      EmailDispatcher.deliver(email)
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
    if @user.password_by_system
        render "reset.rhtml"
      else
      render "login.rhtml"
      end

    else
      @user = Guest.find_by_email(params[:user_name])
     
          render :action=>"index"
      end
  

  end

  def captcha
    respond_to do |format|
      format.js
    end
  end
end
