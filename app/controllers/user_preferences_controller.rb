class UserPreferencesController < ApplicationController
  # System Logging done...

  def change_email
    if @current_user.security_email == params[:old_email] && params[:new_email]== params[:retype_new_email]
      @current_user.update_login_account_password = true
      @current_user.security_email = params[:new_email]
      if @current_user.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated its security email.")
        flash.now[:save_message] = "Security email is changed to #{@current_user.security_email}"
        email = EmailDispatcher.create_email_with_template(@current_user.security_email, 'Comfirmation letter', 'email_dispatcher/send_change_email_comfirmation_letter', @current_user)
        EmailDispatcher.deliver(email)
      else
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update its security email.")
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "security_email")
      end
    else
      flash.now[:error] = "Invalid old email " if @current_user.security_email != params[:old_email]
      flash.now[:error] = "Two emails are not matched" if params[:new_email] != params[:retype_new_email]
    end
    respond_to do |format|
      format.js
    end
    
  end


  def change_password
    if (Digest::SHA256.hexdigest(params[:old_password] + @current_user.password_salt) == @current_user.password_hash  && params[:new_password]== params[:retype_new_password])
      @current_user.password = params[:new_password]
      if @current_user.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated its password.")
        flash.now[:save_message] = "Password is updated successfully"
        email = EmailDispatcher.create_change_password_email_with_template(@current_user.security_email, 'Comfirmation letter', 'email_dispatcher/send_change_password_comfirmation_letter', @current_user,params[:new_password])
        EmailDispatcher.deliver(email)
      else
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update its password.")
        flash.now[:error]="Can't not update password"
      end
    else
      flash.now[:error]="Invalid old password" if Digest::SHA256.hexdigest(params[:old_password] + @current_user.password_salt) != @current_user.password_hash
      flash.now[:error]="Two password are not matched " if params[:new_password] != params[:retype_new_password]
    end
    respond_to do |format|
      format.js{render 'change_email.js'}
    end
    
  end


  def change_security_question
    @current_user.update_login_account_password = true
    if  @current_user.update_attributes(params[:login_account])
      flash.now[:save_message] = "Security questions and answers are updated successfully"
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated its security question.")
      email = EmailDispatcher.create_email_with_template(@current_user.security_email, 'Comfirmation letter', 'email_dispatcher/send_change_security_question_comfirmation_letter', @current_user)
      EmailDispatcher.deliver(email)
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update its security question .")
      flash.now[:error] = "Please Complete All Questions"
    end

    respond_to do |format|
      format.js {render 'change_email.js'}
    end
  end

  def  show_modify_my_account

    @my_account = @current_user
    respond_to do |format|
      format.js
    end
  end

  def show_whoami
    respond_to do |format|
      format.js
    end
  end

  def default_value
    @default_value = @current_user.default_value.nil? ? UserPreference.new : @current_user.default_value
    @end_date = @default_value.new_record? ? "01-01-3000" : @default_value.default_end_date.to_s
    @start_date = @default_value.new_record? ? "01-01-3000" : @default_value.default_end_date.to_s
    respond_to do |format|
      format.js
    end
  end

  def create
    @default_value = UserPreference.new(params[:user_preference])
    @current_tab = params[:current_tab]

    if @default_value.save!
      flash[:message] = "successfull update default value"
    else
      
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @default_value = UserPreference.find(params[:id])
    @current_tab = params[:current_tab]
    if @default_value.update_attributes(params[:user_preference])
      flash[:message] = "successfull update default value"

    else

    end
    
    respond_to do |format|
      format.js
    end
  end

  def update_default_value
    @default_value = UserPreference.find(params[:id])
    
    respond_to do |format|
      format.js
    end
  end
  
end
