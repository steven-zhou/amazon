class ReceiptAllocationsController < ApplicationController
  # System Log stuff added

  def new
    @entity_receipt = EntityReceipt.find(params[:param1])
    @deposit = @entity_receipt.deposit
    @receipt_allocation = ReceiptAllocation.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @receipt_allocation = ReceiptAllocation.new(params[:receipt_allocation])
    
    if @receipt_allocation.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new receipt allocation with ID #{@receipt_allocation.id}.")
    else
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new receipt allocation.")
      #----------------------------presence - of--------------------
      if(!@receipt_allocation.errors[:entity_receipt_id].nil? && @receipt_allocation.errors.on(:entity_receipt_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@receipt_allocation.errors[:amount].nil? && @receipt_allocation.errors.on(:amount).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@receipt_allocation.errors[:receipt_account_id].nil? && @receipt_allocation.errors.on(:receipt_account_id).include?("can't be blank"))
        flash.now[:error] = "Please Enter All Required Data"
      elsif(!@receipt_allocation.errors[:receipt_account_id].nil? && @receipt_allocation.errors.on(:receipt_account_id).include?("has already been taken"))
        flash.now[:error] = "A record with same receipt account already exists, please try other receipt accounts"
      end
    end
    
    #update entity receipt total amount
    @entity_receipt = @receipt_allocation.entity_receipt
    entity_value = 0
    @entity_receipt.receipt_allocations.each do |i|
      entity_value += i.amount.to_f
    end
    @entity_receipt.update_attribute(:amount, entity_value)

    #update deposit total amount
    @receipt_value = 0
    @deposit = @entity_receipt.deposit
    @deposit.entity_receipts.each do |e|
      @receipt_value += e.amount.to_f
    end

    respond_to do |format|
      format.js
    end
  end


  def destroy

    @receipt_allocation = ReceiptAllocation.find(params[:id])
    @entity_receipt = @receipt_allocation.entity_receipt
    @deposit = @entity_receipt.deposit
    @receipt_allocation.destroy
    
    #for re-calculate the total amount of the receipt
    @receipt_value = 0
    @entity_receipt.receipt_allocations.each do |r|
      @receipt_value += r.amount.to_f
    end
    @entity_receipt.update_attribute(:amount, @receipt_value)
    @deposit.update_attribute(:total_amount, @receipt_value)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted receipt.")

    if @entity_receipt.receipt_allocations.blank?
      @clear = true
    end
    respond_to do |format|
      format.js
    end
  end

  #
  #
  #  def filter
  #    @date_valid = true
  #    conditions = Array.new
  #    values = Array.new
  #    query_conditions = Array.new
  #    @entity = session[:entity_type].camelize.constantize.find(session[:entity_id])
  #    conditions << "receipts.entity_type =?"
  #    values << session[:entity_type]
  #    conditions << "receipts.entity_id = ?"
  #    values << session[:entity_id]
  #    conditions << "receipt_account_id Is Not Null"
  #
  #
  #    if valid_date(params[:start_deposit_date]) && valid_date(params[:end_deposit_date])
  #      if (!params[:start_deposit_date].blank? || !params[:end_deposit_date].blank?)
  #        params[:start_deposit_date] = "01-01-#{Date.today().year().to_s}"if params[:start_deposit_date].blank?
  #        params[:end_deposit_date] = "31-12-#{Date.today().year().to_s}"if params[:end_deposit_date].blank?
  #        query_conditions << ("start_deposit_date=" + params[:start_deposit_date])
  #        query_conditions << ("end_deposit_date=" + params[:end_deposit_date])
  #      end
  #      @date_valid = true
  #      @start_date = params[:start_deposit_date]
  #      @end_date = params[:end_deposit_date]
  #    else
  #      @date_valid = false
  #      flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
  #    end
  #
  #
  #
  #    if params[:start_deposit_date]
  #      conditions << "deposits.deposit_date >= ?"
  #      values << params[:start_deposit_date].to_date
  #    end
  #    if params[:end_deposit_date]
  #      conditions << "deposits.deposit_date <= ?"
  #      values << params[:end_deposit_date].to_date
  #    end
  #    if (params[:receipt_account_id] && params[:receipt_account_id].to_i!= 0)
  #      conditions << "receipt_account_id = ?"
  #      values << params[:receipt_account_id]
  #    end
  #    if (params[:campaign_id] && params[:campaign_id].to_i!= 0)
  #      conditions << "campaign_id = ?"
  #      values << params[:campaign_id]
  #    end
  #    if (params[:source_id] && params[:source_id].to_i!= 0)
  #      conditions << "source_id = ?"
  #      values << params[:source_id]
  #    end
  #
  #
  #    query_conditions << ("receipts.entity_type=#{session[:entity_type]}")
  #    query_conditions << ("receipts.entity_id=#{session[:entity_id]}")
  #
  #    if (params[:receipt_account_id] && params[:receipt_account_id].to_i!= 0)
  #      query_conditions << ("receipt_account_id=" + params[:receipt_account_id])
  #    end
  #
  #    if (params[:campaign_id] && params[:campaign_id].to_i!= 0)
  #      query_conditions << ("campaign_id=" + params[:campaign_id])
  #    end
  #
  #    if (params[:source_id] && params[:source_id].to_i!= 0)
  #      query_conditions << ("source_id=" + params[:source_id])
  #    end
  #
  #
  #    @query = query_conditions.join('&').gsub("receipts.","")
  #    if @date_valid
  #      @receipts = Receipt.find(:all,
  #        :conditions => [conditions.join(' AND '), *values],
  #        :include => ["deposit"])
  #      @count = @receipts.size
  #      if @count > 0
  #        generate_html("receipt_enquiry", "receipts/receipt_enquiry_result", "receipt_enquiry_result")
  #      end
  #    end
  #
  #    respond_to do |format|
  #      format.js
  #    end
  #  end
  #
  #  def show_pdf
  #    convert_html_to_pdf("receipt_enquiry","receipt_enquiry_result","receipt_enquiry_result", {:option => "--page-size A5"})
  #
  #    respond_to do |format|
  #      format.pdf {send_file("public/temp/#{@current_user.user_name}/receipt_enquiry/receipt_enquiry_result.pdf", :filename => "receipt_enquiry_result.pdf", :type => "application/pdf")}
  #    end
  #  end

  
end
