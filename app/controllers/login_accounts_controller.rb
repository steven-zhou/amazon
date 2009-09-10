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
    
    if request.post?
      if @login_account.save
        flash.now[:message] = " Saved successfully"
      else
        flash.now[:error] = " Saved unsuccessfully, please check again"
    
      end

      @login_accounts = LoginAccount.find(:all)
      respond_to  do |format|
        format.js
      end
    
    end
  end


  def edit
    @login_account = LoginAccount.find(params[:id].to_i)

    respond_to do |format|
      format.js
    end
  end

  def update
    @login_account = LoginAccount.find(params[:id].to_i)

    if @login_account.update_attribute(:person_id, params[:login_account][:person_id]) && @login_account.update_attribute(:user_name, params[:login_account][:user_name])

      respond_to do |format|
        format.js
      end
    end
  end















end
