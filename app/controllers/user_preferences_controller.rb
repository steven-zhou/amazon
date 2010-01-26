class UserPreferencesController < ApplicationController


  def change_email
    current_user = LoginAccount.find(session[:user])

    if current_user.security_email == params[:old_email]

#     current_user.security_email = params[:new_email]
       unless current_user.update_attribute(:security_email,params[:new_email])    
        flash[:error]="Can not save"
       end
    else
     flash[:error]="old and new is not the same"

    end

     respond_to do |format|
      format.js
    end
    
  end

  def  show_modify_my_account

  @my_account = LoginAccount.find(session[:user])
   respond_to do |format|
      format.js
    end
  end




  
end
