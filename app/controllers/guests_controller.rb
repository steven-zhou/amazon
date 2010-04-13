class GuestsController < ApplicationController

  layout nil
  include SimpleCaptcha::ControllerHelpers
  before_filter :check_authentication, :except => [:index, :new, :create, :login, :captcha, :reset, :show]
  before_filter :guest_authentication, :except => [:index, :new, :create, :login, :captcha, :reset]

  def guest_authentication
    unless session[:guest]
      redirect_to :action => 'index'
    else
      @current_guest = Guest.find(session[:guest])
      redirect_to :action => 'reset' if (@current_guest.password_by_system)
    end
  end

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

    begin
      @guest = Guest.authenticate(params[:user_name],params[:password])
      session[:guest] = @guest.id
      redirect_to :action => 'show'
    rescue
      flash[:warning] = flash_message(:type => "login_error")
      puts "there is a error"
      redirect_to :action => 'index'
    end
    

  end

  def captcha
    respond_to do |format|
      format.js
    end
  end

  def reset

    respond_to do |format|
      format.html
    end
  end

  def show

    respond_to do |format|
      format.html
    end
  end
  
end