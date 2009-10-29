class LoginAccountsController < ApplicationController
  # before_filter :put_current_user_into_model

  def user_name_unique
    @error_flag_unique = (LoginAccount.find_by_user_name(params[:user_name]).nil?) ? false : true
    @error_flag_length = ( params[:length].to_i > 6 && params[:length].to_i < 30 ) ? false : true
    @login_account = LoginAccount.find(params[:login_account_id]) rescue @login_account = LoginAccount.new
  
    unless @login_account.new_record? 
      if (@login_account == LoginAccount.find_by_user_name(params[:user_name]))
          @error_flag_unique = false
      end
    end
    
    if @error_flag_unique
      flash.now[:error] = "The username has been taken"    
    elsif @error_flag_length
      flash.now[:error] = "The Username Length is wrong, please choose between 6 to 30"    
    end
    respond_to  do |format|
      format.js
    end
  end

  def create
    @login_account = LoginAccount.new(params[:login_account])
    password_s = LoginAccount.generate_password
    @login_account.password = password_s
    if @login_account.save
      email = LoginAccountPasswordResetDispatcher.create_registration_confirmation(@login_account, password_s)
      LoginAccountPasswordResetDispatcher.deliver(email)
      flash.now[:message] = " Saved successfully"
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "person_id")if(!@login_account.errors[:person_id].nil? && @login_account.errors.on(:person_id).include?( "can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "password")if(!@login_account.errors[:password].nil? && @login_account.errors.on(:password).include?("password can't be blank"))
      flash.now[:error] = flash_message(:type => "field_missing", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?( "can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "person_id")if(!@login_account.errors[:person_id].nil? && @login_account.errors.on(:person_id).include?("has already been taken"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("has already been taken"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?("has already been taken"))
      flash.now[:error] = flash_message(:type => "format error", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?("Invalid email"))
      flash.now[:error] = flash_message(:type => "not exist", :field => "person_id")if(!@login_account.errors[:person_id].nil? && @login_account.errors.on(:person_id).include?("You must specify a person that exists."))
       
    end

    @login_accounts = LoginAccount.find(:all)
    respond_to  do |format|
      format.js
    end
    
  end


  def edit
    @login_account = LoginAccount.find(params[:id].to_i)
    @user_group = UserGroup.new
    @group_meta_type = GroupMetaType.find(:first, :conditions => ["name=?", "System Users"])rescue  @group_meta_types =  GroupMetaType.new
    #@group_types = GroupType.find(:all, :conditions => ["tag_type_id=?", gp_id])rescue  @group_types =  GroupType.new
    @group_types = @group_meta_type.group_types rescue  @group_types =  GroupType.new
    @login_account = LoginAccount.find(params[:id])
    @groups = @login_account.group_types

    respond_to do |format|
      format.js
    end
  end

  def update
    @login_account = LoginAccount.find(params[:id].to_i)
   
    ad = Array.new
    @user = LoginAccount.find(session[:user])
    @user.group_types.each do |gt|
      ad <<  gt.name.include?("Admin")||gt.name.include?("Super Admin")
       
    end
    if ad.include?(true) #admin
      #, :if => :user_update?
      @login_account.update_password = false
      #        @login_account.user_name = params[:login_account][:user_name]
      #        @login_account.save
      #        @login_account.update_attribute(:security_email,params[:login_account][:security_email])
      #        @login_account.update_attribute(:login_status,params[:login_account][:login_status])
      #        @login_account.update_attribute(:system_user,params[:login_account][:system_user])
      if @login_account.update_attributes(params[:login_account])
        flash.now[:message] = " Saved successfully"
      else

        flash.now[:error] = flash_message(:type => "field_missing", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("can't be blank"))
        flash.now[:error] = flash_message(:type => "too_short_name", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("pick a longer name"))
        flash.now[:error] = flash_message(:type => "too_long_name", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("pick a shorter name"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?( "can't be blank"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "format error", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?("Invalid email"))

      end
    elsif ad.include?(false) #user
      @login_account.update_password = false
      if @login_account.update_attributes(params[:login_account])
   
        flash.now[:message] = " Saved successfully"
      else
        flash.now[:error] = flash_message(:type => "field_missing", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("can't be blank"))
        flash.now[:error] = flash_message(:type => "field_missing", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?( "can't be blank"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "user_name")if(!@login_account.errors[:user_name].nil? && @login_account.errors.on(:user_name).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?("has already been taken"))
        flash.now[:error] = flash_message(:type => "format error", :field => "security_email")if(!@login_account.errors[:security_email].nil? && @login_account.errors.on(:security_email).include?("Invalid email"))
  
      end
    end
    @login_accounts = LoginAccount.find(:all)
    respond_to do |format|
      format.js
    end
    
  end


  def destroy

    @login_account = LoginAccount.find(params[:id].to_i)
    @user_group = @login_account.user_groups
    for ug in @user_group
      ug.destroy
    end
    @login_account.destroy
    @login_accounts = LoginAccount.all
   

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
      flash.now[:message] = " change the password already"
    end

    respond_to do |format|
      format.js
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
