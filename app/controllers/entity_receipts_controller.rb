class EntityReceiptsController < ApplicationController
  # System Log stuff added

  def new    
    @deposit = Deposit.find(params[:param1])
    @receipt = EntityReceipt.new
    respond_to do |format|
      format.js
    end
  end


  def create
    @deposit= Deposit.find(params[:entity_receipt][:deposit_id])
    if params[:entity_receipt][:entity_id]
      @entity = params[:entity_receipt][:entity_type].camelize.constantize.find(params[:entity_receipt][:entity_id]) rescue @entity = nil
    end

    if @entity.nil?
      flash.now[:error] = "#{params[:entity_receipt][:entity_type]} #{params[:entity_receipt][:entity_id]} can not be found"
    else    
      @receipt = @entity.entity_receipts.new(params[:entity_receipt])

      
      if @receipt.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new receipt with ID #{@receipt.id}.")
      else
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new @receipt.")
        #----------------------------presence - of--------------------
        if(!@receipt.errors[:entity_receipt].nil? && @receipt.errors.on(:entity_receipt).include?("can't be blank"))
          flash.now[:error] = "Please Enter All Required Data"
        elsif(!@receipt.errors[:receipt_account_id].nil? && @receipt.errors.on(:receipt_account_id).include?("can't be blank"))
          flash.now[:error] = "Please Enter All Required Data"
        elsif(!@receipt.errors[:amount].nil? && @receipt.errors.on(:amount).include?("can't be blank"))
          flash.now[:error] = "Please Enter All Required Data"
        elsif(!@receipt.errors[:entity_id].nil? && @receipt.errors.on(:entity_id).include?("has already been taken"))
          flash.now[:error] = "A record with same extension already exists"
        else
          flash.now[:error] = "A record with same receipt account already exists, please try other receipt accounts"
        end
      end
    
    end
    respond_to do |format|
      format.js
    end
  end


  def destroy
    @entity_receipt = EntityReceipt.find(params[:id])
    @deposit = @entity_receipt.deposit
    @entity.destroy


 #for re-calculate the total amount of the receipt
    receipt_value = 0
    @entity.receipt_allocations.each do |r|
      receipt_value += r.amount.to_f
    end
  
    @deposit.update_attribute(:total_amount, receipt_value)


    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted extension.")

    respond_to do |format|
      format.js
    end
  end

  def show
    @entity_receipt = EntityReceipt.find(params[:grid_object_id])
    respond_to do |format|
      format.js
    end
  end

  
end
