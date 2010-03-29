class ReceiptsController < ApplicationController
  # System Log stuff added

  def new    
    @deposit = Deposit.find(params[:param1])
    @receipt = EntityReceipt.new
    respond_to do |format|
      format.js
    end
  end


  def create
    @deposit= Deposit.find(params[:receipt][:deposit_id])
    if params[:receipt][:entity_id]
      @entity = params[:receipt][:entity_type].camelize.constantize.find(params[:receipt][:entity_id]) rescue @entity = nil
    end

    if @entity.nil?
      flash.now[:error] = "#{params[:receipt][:entity_type]} #{params[:receipt][:entity_id]} can not be found"
    else    
      @receipt = @entity.receipts.new(params[:receipt])
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
      @receipts = Receipt.find(:all,
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

    convert_html_to_pdf("receipt_enquiry","receipt_enquiry_result","receipt_enquiry_result", {:option => "--page-size A5"})


    respond_to do |format|
      format.pdf {send_file("public/temp/#{@current_user.user_name}/receipt_enquiry/receipt_enquiry_result.pdf", :filename => "receipt_enquiry_result.pdf", :type => "application/pdf")}
    end
  end

  
end
