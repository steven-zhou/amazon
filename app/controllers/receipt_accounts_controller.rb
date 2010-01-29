class ReceiptAccountsController < ApplicationController
  
  def new_receipt_account
    @receipt_account = ReceiptAccount.new
    respond_to do |format|
      format.js
    end
  end

  def create_receipt_account
    @receipt_account = ReceiptAccount.new(params[:receipt_account])
    @receipt_account.link_module_name = LinkModule.find(params[:receipt_account][:link_module_id].to_i).name rescue @receipt_account.link_module_name = ""
    @receipt_account.to_be_removed = false
    if @receipt_account.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new receipt account with ID #{@receipt_account.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a receipt account.")
      if(!@receipt_account.errors[:name].nil?)
        flash.now[:error] = "Please Enter A Unique Name"
      elsif(!@receipt_account.errors[:link_module_id].nil?)
        flash.now[:error] = "Please Select A Link Module"
      end
    end


    respond_to do |format|
      format.js
    end
  end

  def update_receipt_account
    @receipt_account = ReceiptAccount.find(params[:id])
    if (@receipt_account.status == false)
      @receipt_account.update_attribute(:status,params[:receipt_account][:status])
    else
      params[:receipt_account][:link_module_name] = LinkModule.find(params[:receipt_account][:link_module_id].to_i).name rescue params[:receipt_account][:link_module_name] = ""
      if @receipt_account.update_attributes(params[:receipt_account])
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated a new receipt_account with ID #{@receipt_account.id}.")
      else
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a receipt account #{@receipt_account.id}.")
        if(!@receipt_account.errors[:name].nil?)
          flash.now[:error] = "Please Enter A Unique Name"
        elsif(!@receipt_account.errors[:link_module_id].nil?)
          flash.now[:error] = "Please Select A Link Module"
        end
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

  def copy

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
    @receipt_account.link_module_id = @receipt_account_old.link_module_id
    @receipt_account.link_module_name = @receipt_account_old.link_module_name
    @receipt_account.post_to_history = @receipt_account_old.post_to_history
    @receipt_account.post_to_campaign = @receipt_account_old.post_to_campaign
    @receipt_account.send_receipt = @receipt_account_old.send_receipt
    @receipt_account.status = @receipt_account_old.status
    @receipt_account.remarks = @receipt_account_old.remarks
    @receipt_account.to_be_removed = false
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
    @receipt_account.to_be_removed = true
    @receipt_account.save
    respond_to do |format|
      format.js
    end    
  end

  def retrieve_receipt_account
    @receipt_account = ReceiptAccount.find(params[:id])
    @receipt_account.to_be_removed = false
    @receipt_account.save
    respond_to do |format|
      format.js {render 'destroy_receipt_account.js'}
    end
  end


end
