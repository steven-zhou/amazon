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

      puts "****************"
      puts @receipt
      puts @entity
      
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
    p = params[:id].split("-")
    @entity = p[0].camelize.constantize.find(p[1])
    @deposit = Deposit.find(p[2])
    @receipts = @entity.receipts.find(:all, :conditions => ["deposit_id = ?", @deposit.id])
    @receipts.each do |i|
      i.destroy
    end

    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted extension.")

    respond_to do |format|
      format.js
    end
  end

  
end
