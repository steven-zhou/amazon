class ReceiptsController < ApplicationController
  # System Log stuff added

  def new    

      @receipt = Receipt.new
      @deposit_id = params[:param1]
      @field = params[:param2]

  end

  def edit
    @receipt = Receipt.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def temp_edit
    @temp_transaction_allocation_grid = TempTransactionAllocationGrid.find(params[:grid_object_id])
    respond_to do |format|
      format.js
    end
  end

  def create
#    @receipt = Receipt.new(params[:receipt])
    @deposit_id = params[:receipt][:deposit_id]

    #for no extenion

    @entity = Deposit.find(@deposit_id).entity
#    params[:receipt][:entity_id] =@entity.id
#    params[:receipt][:entity_type]= @entity.type
    @receipt = @entity.receipts.new(params[:receipt])
    @field = params[:field]

    puts "*******"
    puts @field


    if @receipt.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new receipt with ID #{@receipt.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new @receipt.")
      #----------------------------presence - of--------------------
      if(!@receipt.errors[:deposit_id].nil? && @receipt.errors.on(:deposit_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@receipt.errors[:receipt_account_id].nil? && !@receipt.errors.on(:receipt_account_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@receipt.errors[:amount].nil? && !@receipt.errors.on(:amount).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      else
        flash.now[:error] = "A record with same receipt account already exists, please try other receipt accounts"
      end
    end
    @deposit= Deposit.find(@deposit_id)
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


  def destroy

    @receipt = Receipt.find(params[:id])
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

  
  def temp_update
    @temp_transaction_allocation_grid = TempTransactionAllocationGrid.find(params[:id])
    if @temp_transaction_allocation_grid.update_attributes(params[:temp_transaction_allocation_grid])
      #system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for Transaction Allocation with ID #{@transaction_allocation.id}.")
    else
      #system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a transaction allocation record.")
      #----------------------------presence - of------------------
      if(!@temp_transaction_allocation_grid.errors[:field_1].nil? && @temp_transaction_allocation_grid.errors.on(:field_1).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@temp_transaction_allocation_grid.errors[:field_5].nil? && @temp_transaction_allocation_grid.errors.on(:field_5).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      else
        flash.now[:error] = "A record with same receipt account already exists, please try other receipt accounts"
      end
    end

    @temp_allocations = @current_user.all_temp_allocation
    @temp_allocation_value = 0
    @temp_allocations.each do |temp_transaction|
      @temp_allocation_value += temp_transaction.field_5.to_f
    end

    respond_to do |format|
      format.js
    end
  end

  def update
    @transaction_allocation = TransactionAllocation.find(params[:id])
    if @transaction_allocation.update_attributes(params[:transaction_allocation])
      #system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for Transaction Allocation with ID #{@transaction_allocation.id}.")
    else
      #system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a transaction allocation record.")
      #----------------------------presence - of------------------
      if(!@transaction_allocation.errors[:receipt_account_id].nil? && @transaction_allocation.errors.on(:receipt_account_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@transaction_allocation.errors[:amount].nil? && @transaction_allocation.errors.on(:amount).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      else
        flash.now[:error] = "A record with same receipt account already exists, please try other receipt accounts"
      end
    end
    @transaction_header_id = @transaction_allocation.transaction_header_id
   
    @transaction_header = @transaction_allocation.transaction_header
    @transaction_allocations = @transaction_header.transaction_allocations
    @transaction_allocation_value = 0
    @transaction_allocations.each do |transaction_transaction|
      @transaction_allocation_value += transaction_transaction.amount.to_f
    end
    @transaction_header.update_attribute(:total_amount,@transaction_allocation_value )
    respond_to do |format|
      format.js
    end
  end

  def temp_create
    @temp_transaction_allocation_grid = TempTransactionAllocationGrid.new(params[:temp_transaction_allocation_grid])
    @temp_transaction_allocation_grid.login_account_id = @current_user.id
    if @temp_transaction_allocation_grid.save
   



      
    else
      #----------------------------presence - of--------------------
      if(!@temp_transaction_allocation_grid.errors[:field_1].nil? && @temp_transaction_allocation_grid.errors.on(:field_1).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@temp_transaction_allocation_grid.errors[:field_5].nil? && @temp_transaction_allocation_grid.errors.on(:field_5).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      else
        flash.now[:error] = "A record with same receipt account already exists, please try other receipt accounts"
      end
    end

    @temp_allocations = @current_user.all_temp_allocation
    @temp_allocation_value = 0
    @temp_allocations.each do |temp_transaction|
      @temp_allocation_value += temp_transaction.field_5.to_f
    end
    
    respond_to do |format|
      format.js
    end
  end

  def extention_name_finder


  end


  
end
