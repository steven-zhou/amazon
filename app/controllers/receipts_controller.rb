class ReceiptsController < ApplicationController
  # System Log stuff added

  def new    
    @deposit = Deposit.find(params[:param1])

    @entity = @deposit.entity
    @is_extension = true if (params[:param2] == "extension")
    if @is_extension
      #left
       @receipt = Receipt.new
    else
      #right
      if @entity.receipts.find(:all, :conditions => ["deposit_id = ? and receipt_account_id IsNull", @deposit.id]).empty?
        @receipt = Receipt.new
      else
        @receipt = Receipt.find_by_deposit_id(params[:param1])
      end
    end    

    respond_to do |format|
      format.js
    end
  end

  def edit
    @receipt = Receipt.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @deposit= Deposit.find(params[:receipt][:deposit_id])
    if params[:receipt][:entity_id]
      @entity = params[:receipt][:entity_type].camelize.constantize.find(params[:receipt][:entity_id]) rescue @entity = nil
    else
      @entity = @deposit.entity
    end

    if @entity.nil?
      flash.now[:error] = "#{params[:receipt][:entity_type]} #{params[:receipt][:entity_id]} can not be found"
    else    
      @receipt = @entity.receipts.new(params[:receipt])
      @receipt.extension = params[:is_extension].nil? ? false : true  #switch for correct validation

      if @receipt.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new receipt with ID #{@receipt.id}.")
      else
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new @receipt.")
        #----------------------------presence - of--------------------
        if(!@receipt.errors[:deposit_id].nil? && @receipt.errors.on(:deposit_id).include?("can't be blank"))
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
    
      @receipts = @deposit.receipts
      @receipt_value = 0
      @receipts.each do |r|
        @receipt_value += r.amount.to_f
      end
      @deposit.update_attribute(:total_amount, @receipt_value )
      @is_extension = true if params[:is_extension]
    end
    respond_to do |format|
      format.js
    end
  end


  def destroy

    @receipt = Receipt.find(params[:id])
    @entity=@receipt.entity
    #    @field = params[:field]
    #for the receipt grid
    @deposit_id = @receipt.deposit_id
    @receipt.destroy
    
    #for re-calculate the deposit amount
    @deposit= Deposit.find(@deposit_id)
    @receipts = @deposit.receipts
    @receipt_value = 0
    @receipts.each do |r|
      @receipt_value += r.amount.to_f
    end
   
    @deposit.update_attribute(:total_amount,@receipt_value )
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted receipt.")

    respond_to do |format|
      format.js
    end
  end

  def destroy_extension
    p = params[:id].split("-")
    @entity = p[0].camelize.constantize.find(p[1])
    @deposit = Deposit.find(p[2])
    @receipts = @entity.receipts.find(:all, :conditions => ["deposit_id = ?", @deposit.id])
    @receipts.each do |i|
      i.destroy
    end

    @receipts = @deposit.receipts
    @receipt_value = 0
    @receipts.each do |r|
      @receipt_value += r.amount.to_f
    end

    @deposit.update_attribute(:total_amount,@receipt_value )




    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted extension.")

    respond_to do |format|
      format.js
    end
  end

  
  

  def update
    @receipt = Receipt.find(params[:id])
    @entity = @receipt.entity
    if @receipt.update_attributes(params[:receipt])
      #system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for Transaction Allocation with ID #{@transaction_allocation.id}.")
    else
      #system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a transaction allocation record.")
      #----------------------------presence - of------------------
      if(!@receipt.errors[:receipt_account_id].nil? && @receipt.errors.on(:receipt_account_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@receipt.errors[:amount].nil? && @receipt.errors.on(:amount).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      else
        flash.now[:error] = "A record with same receipt account already exists, please try other receipt accounts"
      end
    end
    #    @transaction_header_id = @transaction_allocation.transaction_header_id
   
    #    @transaction_header = @receipt.deposit
    #    @transaction_allocations = @transaction_header.transaction_allocations
    #    @transaction_allocation_value = 0
    #    @transaction_allocations.each do |transaction_transaction|
    #      @transaction_allocation_value += transaction_transaction.amount.to_f
    #    end
    #    @transaction_header.update_attribute(:total_amount,@transaction_allocation_value )



    @deposit= Deposit.find(@receipt.deposit_id)
    @receipts = @deposit.receipts
    @receipt_value = 0
    @receipts.each do |r|
      @receipt_value += r.amount.to_f
    end

    @deposit.update_attribute(:total_amount,@receipt_value )
    respond_to do |format|
      format.js
    end
  end


  def extention_name_finder


  end


  def show_extension_receipts
    p = params[:grid_object_id].split("-")
    @entity = p[0].camelize.constantize.find(p[1])
    @deposit = Deposit.find(p[2])
    respond_to do |format|
      format.js
    end
  end
  
end
