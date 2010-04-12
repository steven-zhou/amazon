class GuestsController < ApplicationController

  layout nil

  before_filter :check_authentication, :except => [:index,:new,:create,:login]

  def index


  end

  def new


    
  end


  def create
   guest = Guest.new

    guest.family_name = params[:family_name]
    guest.first_name = params[:first_name]
    guest.phone_num = params[:phone]
    guest.email_address = params[:email]
    guest.password = params[:new_password]
    guest.save


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
