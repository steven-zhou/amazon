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
    query_conditions = Array.new
    @entity = session[:entity_type].camelize.constantize.find(session[:entity_id])
    conditions << "receipts.entity_type =?"
    values << session[:entity_type]
    conditions << "receipts.entity_id = ?"
    values << session[:entity_id]
    conditions << "receipt_account_id Is Not Null"


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
      conditions << "deposits.deposit_date >= ?"
      values << params[:start_deposit_date].to_date
    end
    if params[:end_deposit_date]
      conditions << "deposits.deposit_date <= ?"
      values << params[:end_deposit_date].to_date
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
      @receipts = EntityReceipt.find(:all,
        :conditions => [conditions.join(' AND '), *values],
        :include => ["deposit"])
      @count = @receipts.size
      if @count > 0
        generate_html("receipt_enquiry", "receipts/receipt_enquiry_result", "receipt_enquiry_result")
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def show_pdf

    convert_html_to_pdf("receipt_enquiry","receipt_enquiry_result","receipt_enquiry_result")


    respond_to do |format|
      format.pdf {send_file("public/temp/#{@current_user.user_name}/receipt_enquiry/receipt_enquiry_result.pdf", :filename => "receipt_enquiry_result.pdf", :type => "application/pdf")}
    end
  end

  
end
