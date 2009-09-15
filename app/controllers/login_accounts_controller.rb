class LoginAccountsController < ApplicationController


  def user_name_unique
    @flag = LoginAccount.find_by_user_name(params[:user_name]).nil? ? false : true
    #@login_accounts = LoginAccount.find(:all, :conditions => ["user_name=?",params[:user_name]])unless (params[:user_name].nil? || params[:user_name].empty?)
    @login_account = LoginAccount.find(params[:login_account_id]) rescue @login_account = LoginAccount.new
    respond_to  do |format|
      format.js
    end
  end

  def create
    @login_account = LoginAccount.new(params[:login_account])
    a = String.new
    a = ""
    
    if request.post?
      if @login_account.save
        flash.now[:message] = " Saved successfully"
      else
        a += flash_message(:type => "field_missing", :field => "person_id") + "<p/>" if (!@login_account.errors[:person_id].nil? && @login_account.errors.on(:person_id).include?( "can't be blank"))
        a += flash_message(:type => "field_missing", :field => "user_name") + "<p/>" if (!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("can't be blank"))
        a += flash_message(:type => "field_missing", :field => "password") + "<p/>" if (!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("password can't be blank"))
        a += flash_message(:type => "uniqueness_error", :field => "person_id") + "<p/>" if (!@login_account.errors[:person_id].nil? && @login_account.errors.on(:person_id).include?("has already been taken"))
        a += flash_message(:type => "uniqueness_error", :field => "user_name") + "<p/>" if (!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("has already been taken"))
        a += flash_message(:type => "not exist", :field => "person_id") + "<p/>" if (!@login_account.errors[:person_id].nil? && @login_account.errors.on(:person_id).include?("You must specify a person that exists."))
        if a == ""

          flash.now[:error] = "please check your security answer and password can not the same as username"
        else
          flash.now[:error] = a
        end
      end

      @login_accounts = LoginAccount.find(:all)
      respond_to  do |format|
        format.js
      end
    
    end
  end


  def edit
    @login_account = LoginAccount.find(params[:id].to_i)
    @user_group = UserGroup.new

    respond_to do |format|
      format.js
    end
  end

  def update
    @login_account = LoginAccount.find(params[:id].to_i)
   a = String.new
    a = ""
    #    @login_account.user_name = params[:login_account][:user_name]
    #    @login_account.security_email = params[:login_account][:email]
    #    @login_account.login_status = params[:login_account][:login_status]
    #    @login_account.system_user = params[:login_account][:system_user]
    #if @login_account.update_attribute(:user_name,params[:login_account][:user_name])&& @login_account.update_attribute(:security_email,params[:login_account][:security_email])&& @login_account.update_attribute(:login_status,params[:login_account][:login_status])&& @login_account.update_attribute(:system_user,params[:login_account][:system_user])
    if @login_account.update_attributes(params[:login_account])
   
      flash.now[:message] = " Saved successfully"
    else
      a += flash_message(:type => "field_missing", :field => "user_name") + "<p/>" if (!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("can't be blank"))
      a += flash_message(:type => "uniqueness_error", :field => "user_name") + "<p/>" if (!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("has already been taken"))
      if a == ""
        flash.now[:error] = "username must between 6 to 30 and unique"
      else
        flash.now[:error] = a
      end

    end
      @login_accounts = LoginAccount.find(:all)
    respond_to do |format|
      format.js
    end
    
  end















end
