class TransactionAllocationsController < ApplicationController
  # System Log stuff added

  def new
    @system_date = session[:clocktime].strftime("%d-%m-%Y")
    @transaction_allocation = TransactionAllocation.new
  end

  def edit
    @transaction_allocation = TransactionAllocation.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @transaction_allocation = TransactionAllocation.new(params[:transaction_allocation])
    params[:transaction_header][:receipt_number] = TransactionHeader.last.nil? ? 1 :  (TransactionHeader.last.id + 1).to_i
    @transaction_header.receipt_number = params[:transaction_header][:receipt_number]
    if @transaction_header.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new transaction with ID #{@transaction_header.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new transaction record.")
      #----------------------------presence - of--------------------
      if(!@transaction_header.errors[:transaction_date].nil? && @transaction_header.errors.on(:transaction_date).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_header.errors[:bank_account_id].nil? && @transaction_header.errors.on(:bank_account_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_header.errors[:receipt_meta_type_id].nil? && @transaction_header.errors.on(:receipt_meta_type_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_header.errors[:receipt_type_id].nil? && @transaction_header.errors.on(:receipt_type_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_header.errors[:received_via_id].nil? && @transaction_header.errors.on(:received_via_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      else
        flash.now[:error] = "Exception happen, please try again"
      end
    end
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @transaction_header = TransactionHeader.find(params[:id])
    if @transaction_header.update_attributes(params[:tansaction_header])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for TransactionHeader with ID #{@transaction_header.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a transaction header record.")
      #----------------------------presence - of------------------
      if(!@transaction_header.errors[:transaction_date].nil? && @transaction_header.errors.on(:transaction_date).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_header.errors[:bank_account_id].nil? && @transaction_header.errors.on(:bank_account_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_header.errors[:receipt_meta_type_id].nil? && @transaction_header.errors.on(:receipt_meta_type_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_header.errors[:receipt_type_id].nil? && @transaction_header.errors.on(:receipt_type_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_header.errors[:received_via_id].nil? && @transaction_header.errors.on(:received_via_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      else
        flash.now[:error] = "Exception happen, please try again"
      end
    end
  end





  
end
