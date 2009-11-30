class ReceiptAccountsController < ApplicationController
  
  def new_receipt_account
    @receipt_account = ReceiptAccount.new
    respond_to do |format|
      format.js
    end
  end

  def create_receipt_account
    @receipt_account = ReceiptAccount.new(params[:receipt_account])
    if @receipt_account.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new receipt account with ID #{@receipt_account.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a receipt account.")
      if(!@receipt_account.errors[:name].nil?)
         flash.now[:error] = "Please Enter A Unique Name"
      elsif(!@receipt_account.errors[:receipt_account_type_id].nil?)
         flash.now[:error] = "Please Select A Receipt Account Type"
      end
    end


    respond_to do |format|
      format.js
    end
  end

  def update_receipt_account
    @receipt_account = ReceiptAccount.find(params[:id])
    if @receipt_account.update_attributes(params[:receipt_account])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated a new receipt_account with ID #{@receipt_account.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a receipt account #{@receipt_account.id}.")
      if(!@receipt_account.errors[:name].nil?)
         flash.now[:error] = "Please Enter A Unique Name"
      elsif(!@receipt_account.errors[:receipt_account_type_id].nil?)
         flash.now[:error] = "Please Select A Receipt Account Type"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def edit_receipt_account
    @receipt_account = ReceiptAccount.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def copy_receipt_account
    @receipt_account = ReceiptAccount.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def create_copy_of_receipt_account
    @receipt_account_old = ReceiptAccount.find(params[:source_id].to_i)
    @receipt_account = ReceiptAccount.new
    @receipt_account.name = params[:receipt_account][:name]
    @receipt_account.description = params[:receipt_account][:description]
    @receipt_account.receipt_account_type_id = @receipt_account_old.receipt_account_type_id
    @receipt_account.post_to_history = @receipt_account_old.post_to_history
    @receipt_account.post_to_campaign = @receipt_account_old.post_to_campaign
    @receipt_account.send_receipt = @receipt_account_old.send_receipt
    @receipt_account.status = @receipt_account_old.status
    @receipt_account.remarks = @receipt_account_old.remarks

    if @receipt_account.save

      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new receipt account #{@receipt_account.id}.")
      flash.now[:message] = flash_message(:type => "object_created_successfully", :object => "receipt account")
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "name") if (!@receipt_account.errors.nil? && @receipt_account.errors.on(:name).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "name") if (!@receipt_account.errors.nil? && @receipt_account.errors.on(:name).include?("has already been taken"))
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy_receipt_account
    @receipt_account = ReceiptAccount.find(params[:id])
    @receipt_account.destroy
    respond_to do |format|
      format.js
    end    
  end


end
