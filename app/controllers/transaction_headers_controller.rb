class TransactionHeadersController < ApplicationController
  # System Log stuff added

  def new
    #@system_date = session[:clocktime].strftime("%d-%m-%Y")
    @system_date = session[:clocktime_date]
    @transaction_header = TransactionHeader.new
    @temp_transaction_allocation_grid = @current_user.all_temp_allocation
    for temp_transaction_allocation_grid in @temp_transaction_allocation_grid
      temp_transaction_allocation_grid.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    @transaction_header = TransactionHeader.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @transaction_header = TransactionHeader.new(params[:transaction_header])
    params[:transaction_header][:receipt_number] = TransactionHeader.last.nil? ? 1 :  (TransactionHeader.last.id + 1).to_i
    @transaction_header.receipt_number = params[:transaction_header][:receipt_number]
    @transaction_header.entity_type = session[:entity_type]
    @transaction_header.entity_id = session[:entity_id]
    if @transaction_header.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new transaction with ID #{@transaction_header.id}.")
      @temp_allocations = @current_user.all_temp_allocation
      @temp_allocation_value = 0
      @temp_allocations.each do |temp_transaction|
        @temp_allocation_value += temp_transaction.field_5.to_i
      end
      if @temp_allocations.empty?
        
      else
       
        @current_user.all_temp_allocation.each do |temp_allocation|
          @transaction_allocation = TransactionAllocation.new
          @transaction_allocation.transaction_header_id = @transaction_header.id
          @transaction_allocation.receipt_account_id = temp_allocation.field_1
          @transaction_allocation.campaign_id = temp_allocation.field_2
          @transaction_allocation.source_id = temp_allocation.field_3
          @transaction_allocation.amount= temp_allocation.field_5
          @transaction_allocation.letter_id = temp_allocation.field_4
          @transaction_allocation.letter_sent= ""
          @transaction_allocation.date_sent= ""
          @transaction_allocation.extention_type= temp_allocation.field_6
          @transaction_allocation.extention_id = temp_allocation.field_7
          @transaction_allocation.cluster_type= temp_allocation.field_8
          @transaction_allocation.cluster_id= temp_allocation.field_9
          @transaction_allocation.save

          @transaction_header.total_amount =  @temp_allocation_value
          @transaction_header.save


       
        end
      end
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
    if @transaction_header.update_attributes(params[:transaction_header])
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
    respond_to do |format|
      format.js
    end
  end

  def show
    @transaction_header = TransactionHeader.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def page_initial
    @render_page = params[:render_page]
    @field = params[:field]
    @start_date = "01-01-#{Date.today().year().to_s}"
    @end_date = "31-12-#{Date.today().year().to_s}"
    respond_to do |format|
      format.js
    end
  end

  def filter
    params[:start_date] ||= "01-01-#{Date.today().year().to_s}"
    params[:end_date] ||= "31-12-#{Date.today().year().to_s}"
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    respond_to do |format|
      format.js
    end
  end
end
