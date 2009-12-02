class LoginAccountsController < ApplicationController
  # System Logging done...
 
  def user_name_unique
  
    @error_flag_unique = (LoginAccount.find_by_user_name(params[:user_name]).nil?) ? false : true
    @error_flag_length = ( params[:length].to_i < 6 || params[:length].to_i > 30 || params[:length].blank? ) ? true : false
    @login_account = LoginAccount.find(params[:login_account_id]) rescue @login_account = LoginAccount.new
  
    #    unless @login_account.new_record?
    #      if (@login_account == LoginAccount.find_by_user_name(params[:user_name]))
    #        @error_flag_unique = false
    #      end
    #    end 
    if @error_flag_unique
      flash.now[:error] = "The Required User Name Is Unavailable"
    elsif @error_flag_length
      flash.now[:error] = " Username Must Be Between 6 and 30 Characters Long"
    end
    respond_to  do |format|
      format.js
    end
  end


  def create
    @login_account = SystemUser.new(params[:login_account])
    password_s = LoginAccount.generate_password
    @login_account.password = password_s
    if @login_account.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Login Account with ID #{@login_account.id} and Username #{@login_account.user_name}.")
      email = LoginAccountPasswordResetDispatcher.create_registration_confirmation(@login_account, password_s)
      LoginAccountPasswordResetDispatcher.deliver(email)
      flash.now[:message] = "New User Account is Saved successfully."

    else
      #----------------------------presence - of------------------------#
      if (!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("password can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "password")
      elsif(!@login_account.errors[:session_timeout].nil? && @login_account.errors.on(:session_timeout).include?("can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "session_timeout")
      elsif(!@login_account.errors[:authentication_grace_period].nil? && @login_account.errors.on(:authentication_grace_period).include?("password can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "authentication_grace_period")
      elsif(!@login_account.errors[:access_attempts_count].nil? && @login_account.errors.on(:access_attempts_count).include?( "can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "access_attempts_count")
      elsif(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?( "can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "security_email")
      elsif(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?( "can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "user_name")
      elsif(!@login_account.errors[:person_id].nil? && @login_account.errors.on(:person_id).include?( "can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "person_id")

        #-----------------------validate--presence of ------------------------
      elsif(!@login_account.errors[:person_id].nil? && @login_account.errors.on(:person_id).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "person_id")
      elsif(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "security_email")
      elsif(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "user_name")

        #-----------------------validate--format- ------------------------
      elsif(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?("Invalid email"))
        flash.now[:error] = flash_message(:type => "format error", :field => "security_email")  
      elsif(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("regular expression of username is wrong"))
        flash.now[:error] = flash_message(:type => "format error", :field => "user_name")
        #-----------------------validate--length- ------------------------
      elsif(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?( "pick a shorter name"))
        flash.now[:error] = flash_message(:type => "too_long", :field => "user_name")
      elsif(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?( "pick a longer name"))
        flash.now[:error] = flash_message(:type => "too_short", :field => "user_name")
        #-----------------------validate--person- ------------------------
      elsif(!@login_account.errors[:person_id].nil? && @login_account.errors.on(:person_id).include?("You must specify a person that exists."))
        flash.now[:error] = flash_message(:type => "not exist", :field => "person_id")
      else
        flash.now[:error] = flash_message(:message => "Please Check Your Input, There are some invalid input")
      end
    end
    @login_accounts = SystemUser.find(:all)
    respond_to  do |format|
      format.js
    end
  end

  def edit
    @login_account = LoginAccount.find(params[:id].to_i)
    @groups = @login_account.group_types
    @session_timeout = @login_account.session_timeout
    @grace_period = @login_account.authentication_grace_period
    @access_attempts_count = @login_account.access_attempts_count
    @password_lifetime = @login_account.password_lifetime
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) edited LoginAccount ID #{@login_account.id} #{@login_account.user_name}.")
    respond_to do |format|
      format.js
    end
  end


  def update
    @login_account = SystemUser.find(params[:id].to_i)
    @login_account.update_password = false
    if @login_account.update_attributes(params[:login_account])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Login Account ID #{@login_account.id} #{@login_account.user_name}.")
      flash.now[:message] = " New User Account is Saved successfully."
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "too_short", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("pick a longer name"))
      flash.now[:error] = flash_message(:type => "too_long", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("pick a shorter name"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?( "can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("has already been taken"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?("has already been taken"))
      flash.now[:error] = flash_message(:type => "format error", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?("Invalid email"))
    end
    @login_accounts = SystemUser.find(:all)
    render "update.js"
  end

  def destroy
    @login_account = SystemUser.find(params[:id].to_i)
    @user_group = @login_account.user_groups
    for ug in @user_group
      ug.destroy
    end
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted Login Account #{@login_account.id} #{@login_account.user_name}.")
    @login_account.destroy
    @login_accounts = SystemUser.all
    respond_to do |format|
      format.js
    end
  end

  def generate_password
    @login_account = LoginAccount.find(params[:login_account_id].to_i)
    @login_account.update_password = false
    password_s = LoginAccount.generate_password
    @login_account.password = password_s
    if @login_account.save
      email = LoginAccountPasswordResetDispatcher.create_registration_confirmation(@login_account, password_s)
      LoginAccountPasswordResetDispatcher.deliver(email)
      flash.now[:message] = "A New Password Has Been Generated and Sent to User by Email"
    end
    respond_to do |format|
      format.js
    end
  end

  def change_password
    if (@current_user.account_locked?)
      session[:user] = nil
      flash[:warning] = flash_message(:type => "login_count_error")
      redirect_to login_url
    else
      @login_account = @current_user
      render :layout => 'reset_password'
    end
  end

  def update_password

    old_password = params[:old_password].nil? ? "" : params[:old_password]
    new_password = (params[:system_user].nil? || params[:system_user][:password].nil?) ? "" : params[:system_user][:password]
    new_password_confirmation = (params[:system_user].nil? || params[:system_user][:password_confirmation].nil?) ? "" : params[:system_user][:password_confirmation]
    answer_1 = (params[:system_user].nil? || params[:system_user][:question1_answer].nil?) ? "" : params[:system_user][:question1_answer]
    answer_2 = (params[:system_user].nil? || params[:system_user][:question2_answer].nil?) ? "" : params[:system_user][:question2_answer]
    answer_3 = (params[:system_user].nil? || params[:system_user][:question3_answer].nil?) ? "" : params[:system_user][:question3_answer]




    # If the old password or security answers is wrong decrease access_attempts_count
    # If the access_attempts_count == 0 kick them out

    password_valid = true

    begin
      # Check that the old password was correct
      LoginAccount.authenticate(@current_user.user_name, old_password)
    rescue
      password_valid = false
    end

    if (@current_user.account_locked?)
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had a failed password update attempt and locked their account.")
      session[:user] = nil
      flash[:warning] = flash_message(:type => "login_count_error")
      redirect_to login_url
    elsif (@current_user.question1_answer.downcase != answer_1.downcase || @current_user.question2_answer.downcase != answer_2.downcase || @current_user.question3_answer.downcase != answer_3.downcase)
      # If the answers supplied were invalid
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) supplied invalid security question answers when attempting to change their password.")
      flash[:warning] = flash_message(:message => "The answers to your security questions were wrong.")
      @current_user.access_attempts_count -= 1
      @current_user.save
      redirect_to :action => "change_password"
    elsif(!password_valid)
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) supplied an invalid old password when attempging to change their password.")
      # If they supplied an invalid password
      flash[:warning] = flash_message(:type => "set_password_error")
      @current_user.access_attempts_count -= 1
      @current_user.save
      redirect_to :action => "change_password"
    elsif (new_password != new_password_confirmation)
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) got their password confirmation wrong when attempting to change their password.")
      # If they got the new password and password confirmation wrong
      flash[:warning] = flash_message(:type => "password_confirm_error")
      redirect_to :action => "change_password"
    elsif(!@current_user.new_password_valid?(new_password))
      # Check the new password is not the same as the old password
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) tried to update their password to a password that was the same as their old password.")
      flash[:warning] = flash_message(:type => "new_password_equals_old_password")
      redirect_to :action => "change_password"
    else
      # Change the password
      @current_user.update_password = true
      @current_user.password = new_password
      if @current_user.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated their password.")
        flash[:warning] = flash_message(:type => "password_change_ok")
        redirect_to login_url
      else
        flash[:warning] = flash_message(:type => "set_password_error")
        redirect_to :action => "change_password"
      end
    end

  end


  protected
  def identify_the_admin
    c = Array.new
    @user = LoginAccount.find(session[:user])
    @user.group_types.each do |gt|
      c <<  !gt.name.include?("Admin")||!gt.name.include?("Super Admin")
     
    end
  end
end

