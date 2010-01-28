class UserPreferencesController < ApplicationController


  def change_email
    @current_user = LoginAccount.find(session[:user])
    flash[:error] = nil
    if @current_user.security_email == params[:old_email] && params[:new_email]== params[:retype_new_email]
      if @current_user.update_attribute(:security_email,params[:new_email])
        flash[:save_message]="Saved successfully"
        email = EmailDispatcher.create_email_with_template(@current_user.security_email, 'Comfirmation letter', 'email_dispatcher/send_change_email_comfirmation_letter', @current_user)
        EmailDispatcher.deliver(email)
      else
        flash[:error]="Can not update your email"
      end
    else
      flash[:error]="Please Type The Correct Security Email " if @current_user.security_email != params[:old_email]
      flash[:error]="Two Email Is Not Matched " if params[:new_email] != params[:retype_new_email]
    end

    respond_to do |format|
      format.js
    end
    
  end


  def change_password
    @current_user = LoginAccount.find(session[:user])
     flash[:error] = nil
    if (Digest::SHA256.hexdigest(params[:old_password] + @current_user.password_salt) == @current_user.password_hash  && params[:new_password]== params[:retype_new_password])
      @current_user.password = params[:new_password]
      if @current_user.save
        flash[:save_message]="Saved successfully"
        email = EmailDispatcher.create_change_password_email_with_template(@current_user.security_email, 'Comfirmation letter', 'email_dispatcher/send_change_password_comfirmation_letter', @current_user,params[:new_password])
        EmailDispatcher.deliver(email)
      else
        flash[:error]="Can not change your password"
      end
    else
      flash[:error]="Please Type The Correct Password " if Digest::SHA256.hexdigest(params[:old_password] + @current_user.password_salt) != @current_user.password_hash
      flash[:error]="Two Password Is Not Matched " if params[:new_password] != params[:retype_new_password]

    end

    respond_to do |format|
      format.js{render 'change_email.js'}
    end
    
  end


  def change_security_question
     flash[:error] = nil
    @login_account = LoginAccount.find(session[:user])
    @login_account.update_login_account_password = false
    if  @login_account.update_attributes(params[:login_account])

      flash[:save_message] = " Saved successfully"

      system_log("Login Account #{@login_account.user_name} (#{@login_account.id}) updated their security question.")

      email = EmailDispatcher.create_email_with_template(@login_account.security_email, 'Comfirmation letter', 'email_dispatcher/send_change_security_question_comfirmation_letter', @login_account)
      EmailDispatcher.deliver(email)
    else
      system_log("Login Account #{@login_account.user_name} (#{@login_account.id}) had an error when attempting to update their security question .")

      flash[:error] = "You Must Type Three Security Questions Answer."
    end

    respond_to do |format|
      format.js {render 'change_email.js'}
    end
  end

  def  show_modify_my_account

    @my_account = LoginAccount.find(session[:user])
    respond_to do |format|
      format.js
    end
  end
  
end
