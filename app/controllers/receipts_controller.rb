class ReceiptsController < ApplicationController
  # System Log stuff added

  
  def show_extension_receipts

    @entity_receipt = EntityReceipt.find(params[:grid_object_id])
    @entity = @entity_receipt.entity
    @deposit = @entity_receipt.deposit

    respond_to do |format|
      format.js
    end
  end

  def filter
    @date_valid = true
    conditions = Array.new
    values = Array.new
    r_conditions = Array.new
    r_values = Array.new
    query_conditions = Array.new
    @entity = session[:entity_type].camelize.constantize.find(session[:entity_id])
    r_conditions << "receipts.entity_type =?"
    r_values << session[:entity_type]
    r_conditions << "receipts.entity_id = ?"
    r_values << session[:entity_id]

    if valid_date(params[:start_deposit_date]) && valid_date(params[:end_deposit_date])
      if (!params[:start_deposit_date].blank? || !params[:end_deposit_date].blank?)
        params[:start_deposit_date] = "01-01-#{Date.today().year().to_s}"if params[:start_deposit_date].blank?
        params[:end_deposit_date] = "31-12-#{Date.today().year().to_s}"if params[:end_deposit_date].blank?
        query_conditions << ("start_deposit_date=" + params[:start_deposit_date])
        query_conditions << ("end_deposit_date=" + params[:end_deposit_date])
      end
      @date_valid = true
      @start_date = params[:start_deposit_date]
      @end_date = params[:end_deposit_date]
    else
      @date_valid = false
      flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
    end



    if params[:start_deposit_date]
      r_conditions << "deposits.business_date >= ?"
      r_values << params[:start_deposit_date].to_date
    end
    if params[:end_deposit_date]
      r_conditions << "deposits.business_date <= ?"
      r_values << params[:end_deposit_date].to_date
    end
    if (params[:receipt_account_id] && params[:receipt_account_id].to_i!= 0)
      conditions << "receipt_account_id = ?"
      values << params[:receipt_account_id]
    end
    if (params[:campaign_id] && params[:campaign_id].to_i!= 0)
      conditions << "campaign_id = ?"
      values << params[:campaign_id]
    end
    if (params[:source_id] && params[:source_id].to_i!= 0)
      conditions << "source_id = ?"
      values << params[:source_id]
    end


    query_conditions << ("receipts.entity_type=#{session[:entity_type]}")
    query_conditions << ("receipts.entity_id=#{session[:entity_id]}")
    
    if (params[:receipt_account_id] && params[:receipt_account_id].to_i!= 0)
      query_conditions << ("receipt_account_id=" + params[:receipt_account_id])
    end

    if (params[:campaign_id] && params[:campaign_id].to_i!= 0)
      query_conditions << ("campaign_id=" + params[:campaign_id])
    end

    if (params[:source_id] && params[:source_id].to_i!= 0)
      query_conditions << ("source_id=" + params[:source_id])
    end


    @query = query_conditions.join('&').gsub("receipts.","")
    if @date_valid
      @receipt_allocations = ReceiptAllocation.find(:all,
        :conditions => [conditions.join(' AND '), *values]
      )
      r = Array.new
      @receipt_allocations.each do |i|
        r << i.entity_receipt.id
      end
      r = r.uniq
      @receipts = EntityReceipt.find(:all,
        :conditions => ["receipts.id IN (?) AND " + r_conditions.join(' AND '), r, *r_values],
        :include => ["deposit"]
      )
      @count = @receipts.size
      if @count > 0
        generate_html("receipt_enquiry", "receipts/receipt_enquiry_result", "receipt_enquiry_result")
        generate_html("receipt_enquiry", "receipts/receipt_enquiry_result_detail", "receipt_enquiry_result_detail")
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def test
    
  end

  def show_pdf
    convert_html_to_pdf("receipt_enquiry","receipt_enquiry_result","receipt_enquiry_result")
    send_file("public/temp/#{@current_user.user_name}/receipt_enquiry/receipt_enquiry_result.pdf", :filename => "receipt_enquiry_result.pdf", :type => "application/pdf")    
  end

  def show_detail_pdf
    convert_html_to_pdf("receipt_enquiry","receipt_enquiry_result_detail","receipt_enquiry_result_detail")
    send_file("public/temp/#{@current_user.user_name}/receipt_enquiry/receipt_enquiry_result_detail.pdf", :filename => "receipt_enquiry_result_detail.pdf", :type => "application/pdf")
  end
end
