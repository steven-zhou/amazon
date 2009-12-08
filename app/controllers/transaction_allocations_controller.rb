class TransactionAllocationsController < ApplicationController
  # System Log stuff added

  def new
  
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
    if @transaction_allocation.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new transaction allocation with ID #{@transaction_allocation.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new transaction allocation.")
      #----------------------------presence - of--------------------
      if(!@transaction_allocation.errors[:transaction_header_id].nil? && @transaction_allocation.errors.on(:transaction_header_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_allocation.errors[:receipt_account_id].nil? && @transaction_allocation.errors.on(:receipt_account_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_allocation.errors[:amount].nil? && @transaction_allocation.errors.on(:amount).include?("can't be blank"))
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
    @transaction_allocation = TransactionHeader.find(params[:id])
    if @transaction_allocation.update_attributes(params[:tansaction_header])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for Transaction Allocation with ID #{@transaction_allocation.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a transaction allocation record.")
      #----------------------------presence - of------------------
      if(!@transaction_allocation.errors[:transaction_header_id].nil? && @transaction_allocation.errors.on(:transaction_header_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_allocation.errors[:receipt_account_id].nil? && @transaction_allocation.errors.on(:receipt_account_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_allocation.errors[:amount].nil? && @transaction_allocation.errors.on(:amount).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      else
        flash.now[:error] = "Exception happen, please try again"
      end
    end
  end





  
end
