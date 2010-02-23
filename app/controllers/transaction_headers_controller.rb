class TransactionHeadersController < ApplicationController
  # System Log stuff added

  include OutputPdf
  
  def new
    #@system_date = session[:clocktime].strftime("%d-%m-%Y")
    @system_date = session[:clocktime_date]
    @transaction_header = TransactionHeader.new
    @cheque_detail = ChequeDetail.new
    @credit_card_detail = CreditCardDetail.new
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
    @cheque_detail = @transaction_header.cheque_detail rescue @cheque_detail = ChequeDetail.new
    @credit_card_detail = @transaction_header.credit_card_detail rescue @credit_card_detail = CreditCardDetail.new
    @transaction_allocations = @transaction_header.transaction_allocations
    @transaction_allocation_value = 0
    @transaction_allocations.each do |transaction_transaction|
      @transaction_allocation_value += transaction_transaction.amount.to_f
    end
    respond_to do |format|
      format.js
    end
  end

  def create
    @transaction_header = TransactionHeader.new(params[:transaction_header])
    @transaction_header.entity_type = session[:entity_type]
    @transaction_header.entity_id = session[:entity_id]

    TransactionHeader.transaction do

      if @transaction_header.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new transaction with ID #{@transaction_header.id}.")
        
        #save transaction type detail
        @transaction_type_detail = case @transaction_header.receipt_meta_meta_type.name
        when "Cheque" then ChequeDetail.new(params[:transaction_type_detail])
        when "Credit Card" then CreditCardDetail.new(params[:transaction_type_detail])
        end

        #cash is not implemented
        unless @transaction_header.receipt_meta_meta_type.name == "Cash"
          @transaction_type_detail.transaction_header_id = @transaction_header.id
          @transaction_type_detail.save!
        end
        
        #copy temp allocation to be real allocation
        @temp_allocations = @current_user.all_temp_allocation
        @temp_allocation_value = 0
        @temp_allocations.each do |temp_transaction|
          @temp_allocation_value += temp_transaction.field_5.to_f
        end

        @transaction_header.receipt_number = @transaction_header.id
        @transaction_header.total_amount = @temp_allocation_value
        @transaction_header.save

        if @temp_allocations.empty?

        else

          @current_user.all_temp_allocation.each do |temp_allocation|
            @transaction_allocation = TransactionAllocation.new
            @transaction_allocation.transaction_header_id = @transaction_header.id
            @transaction_allocation.receipt_account_id = temp_allocation.field_1
            @transaction_allocation.campaign_id = temp_allocation.field_2
            @transaction_allocation.source_id = temp_allocation.field_3
            @transaction_allocation.amount= temp_allocation.field_5.to_f
            @transaction_allocation.letter_id = temp_allocation.field_4
            @transaction_allocation.letter_sent= ""
            @transaction_allocation.date_sent= ""
            @transaction_allocation.extention_type= temp_allocation.field_6
            @transaction_allocation.extention_id = temp_allocation.field_7
            @transaction_allocation.cluster_type= temp_allocation.field_8
            @transaction_allocation.cluster_id= temp_allocation.field_9
            @transaction_allocation.save

            @transaction_header.total_amount =  @temp_allocation_value.to_f
            @transaction_header.save



          end
        end
      else
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new transaction record.")
        #----------------------------presence - of--------------------
        if(!@transaction_header.errors[:transaction_date].nil? && @transaction_header.errors.on(:transaction_date).include?("can't be blank"))
          flash.now[:error] = "Please make sure the transaction date is entered in valid format (dd-mm-yyyy)"
        elsif(!@transaction_header.errors[:transaction_date].nil? && @transaction_header.errors.on(:transaction_date).include?("is invalid"))
          flash.now[:error] = "Please make sure the transaction date is entered in valid format (dd-mm-yyyy)"
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
    end

    respond_to do |format|
      format.js
    end
  end
  
  def update
    @transaction_header = TransactionHeader.find(params[:id])
    TransactionHeader.transaction do
      if @transaction_header.update_attributes(params[:transaction_header])
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for TransactionHeader with ID #{@transaction_header.id}.")

        #update transaction type detail
        if @transaction_header.receipt_meta_meta_type.name + ' Detail' == @transaction_header.transaction_type_detail.class.to_s.titleize
          #if receipt meta meta type is not changed
          @transaction_type_detail = @transaction_header.transaction_type_detail
          @transaction_type_detail.update_attributes(params[:transaction_type_detail])
        else
          #else receipt meta meta type is changed, destroy old detail and create a new one
          @transaction_type_detail_old = @transaction_header.transaction_type_detail
          @transaction_type_detail_old.destroy unless @transaction_type_detail_old.nil?
          @transaction_type_detail = case @transaction_header.receipt_meta_meta_type.name
          when "Cheque" then ChequeDetail.new(params[:transaction_type_detail])
          when "Credit Card" then CreditCardDetail.new(params[:transaction_type_detail])
          end

          #cash is not implemented
          unless @transaction_header.receipt_meta_meta_type.name == "Cash"
            @transaction_type_detail.transaction_header_id = @transaction_header.id
            @transaction_type_detail.save!
          end
        end
      else
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a transaction header record.")
        #----------------------------presence - of------------------
        if(!@transaction_header.errors[:transaction_date].nil? && @transaction_header.errors.on(:transaction_date).include?("can't be blank"))
          flash.now[:error] = "Please make sure the transaction date is entered in valid format (dd-mm-yyyy)"
        elsif(!@transaction_header.errors[:transaction_date].nil? && @transaction_header.errors.on(:transaction_date).include?("is invalid"))
          flash.now[:error] = "Please make sure the transaction date is entered in valid format (dd-mm-yyyy)"
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
    if @field == "histroy_page"
      @count = TransactionHeader.count(:all, :conditions => ["entity_id=? and entity_type=? and banked=? and transaction_date >= ? and transaction_date <= ?", session[:entity_id], session[:entity_type], true, @start_date.to_date, @end_date.to_date])
    end
    respond_to do |format|
      format.js
    end
  end

  def filter
    if params[:enquiry] || params[:bank_run]
      if params[:enquiry]
        @filter_target = "enquiry"
      else
        @filter_target = "bank_run"
      end
      @date_valid = true
      conditions = Array.new
      
      if (!params[:start_id].blank? || !params[:end_id].blank?)
        params[:start_id] = TransactionHeader.first_record.id.to_s if params[:start_id].blank?
        params[:end_id] =   TransactionHeader.last_record.id.to_s if params[:end_id].blank?
        conditions << ("start_id=" + params[:start_id].to_i.to_s)
        conditions << ("end_id=" + params[:end_id].to_i.to_s)
      end

      if (!params[:start_receipt_id].blank? || !params[:end_receipt_id].blank?)
        params[:start_receipt_id] = TransactionHeader.first_record.receipt_number.to_s if params[:start_receipt_id].blank?
        params[:end_receipt_id] = TransactionHeader.last_record.receipt_number.to_s if params[:end_receipt_id].blank?
        conditions << ("start_receipt_id=" + params[:start_receipt_id].to_i.to_s)
        conditions << ("end_receipt_id=" + params[:end_receipt_id].to_i.to_s)
      end

      if valid_date(params[:start_system_date]) && valid_date(params[:end_system_date])
        if (!params[:start_system_date].blank? || !params[:end_system_date].blank?)
          params[:start_system_date] = "01-01-#{Date.today().year().to_s}" if params[:start_system_date].blank?
          params[:end_system_date] = "31-12-#{Date.today().year().to_s}" if params[:end_system_date].blank?
          conditions << ("start_system_date=" + params[:start_system_date])
          conditions << ("end_system_date=" + params[:end_system_date])
        end
        @date_valid = true
      else
        @date_valid = false
        flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
      end

      if valid_date(params[:start_transaction_date]) && valid_date(params[:end_transaction_date])
        if (!params[:start_transaction_date].blank? || !params[:end_transaction_date].blank?)
          params[:start_transaction_date] = "01-01-#{Date.today().year().to_s}"if params[:start_transaction_date].blank?
          params[:end_transaction_date] = "31-12-#{Date.today().year().to_s}"if params[:end_transaction_date].blank?
          conditions << ("start_transaction_date=" + params[:start_transaction_date])
          conditions << ("end_transaction_date=" + params[:end_transaction_date])
        end
        @date_valid = true
      else
        @date_valid = false
        flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
      end

      if (params[:bank_account_number] && params[:bank_account_number].to_i!= 0)
        conditions << ("bank_account_id=" + params[:bank_account_number])
      end

      if (params[:banked] && params[:banked]!= "0")
        conditions << ("banked=" + params[:banked])
      end

      if (params[:receipt_meta_type_id] && params[:receipt_meta_type_id]!= "0")
        conditions << ("receipt_meta_type_id=" + params[:receipt_meta_type_id])
      end

      if (params[:receipt_type_id] && params[:receipt_type_id]!= "0")
        conditions << ("receipt_type_id=" + params[:receipt_type_id])
      end

      if (params[:received_via_id] && params[:received_via_id]!= "0")
        conditions << ("received_via_id=" + params[:received_via_id])
      end

      if (params[:receipt_account_id] && params[:receipt_account_id]!= "0")
        conditions << ("receipt_account_id=" + params[:receipt_account_id])
      end

      @query = conditions.join('&')

    else
      #trasnaction histroy
      @filter_target = "histroy"
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      
      if valid_date(@start_date) && valid_date(@end_date)
        @count = TransactionHeader.count(:all, :conditions => ["entity_id=? and entity_type=? and banked=? and transaction_date >= ? and transaction_date <= ?", session[:entity_id], session[:entity_type], true, @start_date.to_date, @end_date.to_date])
        @date_valid = true
      else
        @date_valid = false
        flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
      end
    end
    
    respond_to do |format|
      format.js
    end
  end

  def export_histroy_to_report
    @file_name = params[:file_name].blank? ? "transaction histroy" : params[:file_name]
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) exported a transaction histroy report.")
    respond_to do |format|
      format.pdf {pdf = PDF::Writer.new
        pdf = OutputPdf.generate_transaction_histroy_report_pdf(session[:entity_type], session[:entity_id], params[:start_date], params[:end_date], {}, {})
        send_data(pdf.render, :filename => "#{@file_name}.pdf", :type => "application/pdf")}
    end
  end

  def destroy
    @transaction_header = TransactionHeader.find(params[:id].to_i)
    @transaction_header.destroy
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) destroy a transaction header record with id #{params[:id]}.")
    respond_to do |format|
      format.js
    end
  end

  def enquiry_show_receipt_type
    @receipt_meta_type = ReceiptMetaMetaType.find(params[:param1])rescue  @receipt_meta_type = ReceiptMetaMetaType.new
    if params[:param1] != "0"
      @receipt_types = ReceiptMetaType.find(:all, :conditions => ['tag_meta_type_id = ? ', params[:param1]])
      @options = ""
      @options += "<option value = 0 >All"
      @receipt_types.each do |i|
        @options += '<option value=' + i.id.to_s + '>' + i.name
      end
      @cheque_detail = ChequeDetail.new
      @credit_card_detail = CreditCardDetail.new
    else
      @options = ""
      @options += "<option value = 0 >All"
    end
    respond_to do |format|
      format.js
    end
  end

  def run
    conditions = Array.new
    values = Array.new
    conditions << "banked = ?"
    values << "false"


    @date_valid = true
    if (params[:bank_account_number] && params[:bank_account_number].to_i!= 0)
      conditions << "bank_account_id = ?"
      values << params[:bank_account_number]
    end
    
    if (params[:start_id] || params[:end_id])
      params[:start_id] = TransactionHeader.first_record.id.to_s if params[:start_id].blank?
      params[:end_id] = TransactionHeader.last_record.id.to_s if params[:end_id].blank?
      conditions << "id BETWEEN ? AND ?"
      values << params[:start_id].to_i.to_s
      values << params[:end_id].to_i.to_s
    end

    if (params[:user_id]&&params[:user_id]!="All")
      conditions << "creator_id = ?"
      values << params[:user_id].to_i
    end

    if (params[:start_transaction_date] || params[:end_transaction_date])
      params[:start_transaction_date] = "01-01-#{Date.today().year().to_s}"if params[:start_transaction_date].blank?
      params[:end_transaction_date] = "31-12-#{Date.today().year().to_s}"if params[:end_transaction_date].blank?
      if valid_date(params[:start_transaction_date]) && valid_date(params[:end_transaction_date])
        conditions << "transaction_date BETWEEN ? AND ?"
        values << params[:start_transaction_date].to_date
        values << params[:end_transaction_date].to_date
      else
        @date_valid = false
        flash[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
      end
    end
    
    @transaction_headers = TransactionHeader.find(:all, :conditions => [conditions.join(" AND "), *values])
    
    if @transaction_headers.blank?
      flash[:warning] = "No outstanding transactions found"
    elsif !@date_valid
      flash[:warning] = "Invalid date"
      
    else
      #new Bank Run
      @run = BankRun.new
      BankRun.transaction do
        @run.save
        @transaction_headers.each do |i|
          i.bank_run_id = @run.id
          i.banked = true
          i.save
        end
      end
      flash[:comfirmation] = "<p>Reports are generated and available here:</p>"
      prepare_bank_run_report(@run.id)
    end

    redirect_to :controller => "transactions", :action => "bank_run"
  end

  def prepare_bank_run_report(bank_run_id)
    @client = ClientOrganisation.first
    @run = BankRun.find(bank_run_id)
    @date = @run.created_at.strftime('%d-%m-%Y')
    @time =  @run.created_at.strftime('%I:%m%p')
    @transactions = TransactionHeader.find(:all, :conditions => ["bank_run_id = ?", bank_run_id])
    @accounts = Array.new
    @cash_transactions = Array.new
    @cheque_transactions = Array.new

    # for bank run audit sheet or credit cards receipt
    if params[:BRAS] || params[:CCR]
      @master_transactions = Array.new
      @visa_transactions = Array.new
    end

    # for receipt account summary
    if params[:RAS]
      @receipt_account = ReceiptAccount.active
      @receipt_account_cash = Array.new
      @receipt_account_cheque = Array.new
      @receipt_account_cards = Array.new
    end

    # for receipt type summary
    if params[:RTS]
      @receipt_type_cash = Array.new
      @receipt_type_cheque = Array.new
      @receipt_type_master_cards = Array.new
      @receipt_type_visa_cards = Array.new
    end

    #for bank run campaign summary
    if params[:CS]
      @campaign = Campaign.active_campaign
      @campaign_cash = Array.new
      @campaign_cheque = Array.new
      @campaign_cards = Array.new
    end
    
    
    
    
    @transactions.each do |i|
      bank_account = i.bank_account
      receipt_meta_meta_type = i.receipt_meta_meta_type.try(:name)
      receipt_meta_type = i.receipt_meta_type.try(:name)
      @accounts << bank_account unless @accounts.include?(bank_account)

      if receipt_meta_meta_type == "Cash"
        @cash_transactions[bank_account.id] << i rescue @cash_transactions[bank_account.id]=[i]
      end
      if receipt_meta_meta_type == "Cheque"
        @cheque_transactions[bank_account.id] << i rescue @cheque_transactions[bank_account.id]=[i]
      end

      # for bank run audit sheet or credit cards receipt
      if params[:BRAS] || params[:CCR]
        if receipt_meta_meta_type == "Credit Card"
          if receipt_meta_type == "Master Card"
            @master_transactions[bank_account.id] << i rescue @master_transactions[bank_account.id]=[i]
          elsif receipt_meta_type == "Visa Card"
            @visa_transactions[bank_account.id] << i rescue @visa_transactions[bank_account.id]=[i]
          end
        end
      end

      # for receipt account summary
      if params[:RAS]
        @receipt_account.each do |receipt_account|
          i.transaction_allocations.each do |transaction_allocation|
            if transaction_allocation.receipt_account.name == receipt_account.name
              if transaction_allocation.transaction_header.receipt_meta_meta_type.name == "Cash"
                @receipt_account_cash[bank_account.id+receipt_account.id] << transaction_allocation.amount rescue @receipt_account_cash[bank_account.id+receipt_account.id] = [transaction_allocation.amount]
              elsif transaction_allocation.transaction_header.receipt_meta_meta_type.name == "Cheque"
                @receipt_account_cheque[bank_account.id+receipt_account.id] <<transaction_allocation.amount rescue @receipt_account_cheque[bank_account.id+receipt_account.id] = [transaction_allocation.amount]
              elsif transaction_allocation.transaction_header.receipt_meta_meta_type.name == "Credit Card"
                @receipt_account_cards[bank_account.id+receipt_account.id] <<transaction_allocation.amount rescue @receipt_account_cards[bank_account.id+receipt_account.id] = [transaction_allocation.amount]
              end
            end
          end
        end
      end

      # for receipt type summary
      if params[:RTS]
        i.transaction_allocations.each do |transaction_allocation|
          if transaction_allocation.transaction_header.receipt_meta_meta_type.name == "Cash"
            @receipt_type_cash[bank_account.id] << transaction_allocation.amount rescue @receipt_type_cash[bank_account.id]  = [transaction_allocation.amount]
          elsif transaction_allocation.transaction_header.receipt_meta_meta_type.name == "Cheque"
            @receipt_type_cheque[bank_account.id] <<transaction_allocation.amount rescue @receipt_type_cheque[bank_account.id] = [transaction_allocation.amount]
          elsif transaction_allocation.transaction_header.receipt_meta_type.name == "Master Card"
            @receipt_type_master_cards[bank_account.id] << transaction_allocation.amount rescue @receipt_type_master_cards[bank_account.id] = [transaction_allocation.amount]
          elsif transaction_allocation.transaction_header.receipt_meta_type.name == "Visa Card"
            @receipt_type_visa_cards[bank_account.id] << transaction_allocation.amount rescue @receipt_type_visa_card[bank_account.id] = [transaction_allocation.amount]
          end
        end
      end


      #for bank run campaign summary
      if params[:CS]
        @campaign.each do |campaign|
          i.transaction_allocations.each do |transaction_allocation|
            if transaction_allocation.campaign.try(:name) == campaign.name
              if transaction_allocation.transaction_header.receipt_meta_meta_type.name == "Cash"
                @campaign_cash[bank_account.id+campaign.id] << transaction_allocation.amount rescue @campaign_cash[bank_account.id+campaign.id] = [transaction_allocation.amount]
              elsif transaction_allocation.transaction_header.receipt_meta_meta_type.name == "Cheque"
                @campaign_cheque[bank_account.id+campaign.id] <<transaction_allocation.amount rescue @campaign_cheque[bank_account.id+campaign.id] = [transaction_allocation.amount]
              elsif transaction_allocation.transaction_header.receipt_meta_meta_type.name == "Credit Card"
                @campaign_cards[bank_account.id+campaign.id] <<transaction_allocation.amount rescue @campaign_cards[bank_account.id+campaign.id] = [transaction_allocation.amount]
              end
            end
          end
        end
      end

    end

    #config temp folder
    file_prefix = "public"
    file_dir = "temp/#{@current_user.user_name}/bank_run_reports"
    FileUtils.mkdir_p("#{file_prefix}/#{file_dir}")

    #prepare bank deposit sheet

    @bank_deposit_sheet = render_to_string(:partial => "transactions/bank_deposit_sheet")
    File.open("#{file_prefix}/#{file_dir}/#{@run.id}-BankDepositSheet.html", 'w') do |f|
      f.puts "#{@bank_deposit_sheet}"
    end
    system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-BankDepositSheet.html #{file_prefix}/#{file_dir}/#{@run.id}-BankDepositSheet.pdf; rm #{file_prefix}/#{file_dir}/#{@run.id}-BankDepositSheet.html"
    flash[:comfirmation] << "<p>BankDepositSheet: <a href=\'/#{file_dir}/#{@run.id}-BankDepositSheet.pdf\'>#{@run.id}-BankDepositSheet.pdf</a></p>"


    #prepare bank run audit sheet
    if params[:BRAS]
      @bank_run_audit_sheet = render_to_string(:partial => "transactions/bank_run_audit_sheet")
      File.open("#{file_prefix}/#{file_dir}/#{@run.id}-BankRunAuditSheet.html", 'w') do |f|
        f.puts "#{@bank_run_audit_sheet}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-BankRunAuditSheet.html #{file_prefix}/#{file_dir}/#{@run.id}-BankRunAuditSheet.pdf; rm #{file_prefix}/#{file_dir}/#{@run.id}-BankRunAuditSheet.html"
      flash[:comfirmation] << "<p>BankRunAuditSheet: <a href=\'/#{file_dir}/#{@run.id}-BankRunAuditSheet.pdf\'>#{@run.id}-BankRunAuditSheet.pdf</a></p>"
    end
    
    #prepare bank run campaign summary
    if params[:CS]
      @bank_run_campaign_summary = render_to_string(:partial => "transactions/bank_run_campaign_summary")
      File.open("#{file_prefix}/#{file_dir}/#{@run.id}-BankRunCampaignSummary.html", 'w') do |f|
        f.puts "#{@bank_run_campaign_summary}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-BankRunCampaignSummary.html #{file_prefix}/#{file_dir}/#{@run.id}-BankRunCampaignSummary.pdf; rm #{file_prefix}/#{file_dir}/#{@run.id}-BankRunCampaignSummary.html"
      flash[:comfirmation] << "<p>BankRunCampaignSummary: <a href=\'/#{file_dir}/#{@run.id}-BankRunCampaignSummary.pdf\'>#{@run.id}-BankRunCampaignSummary.pdf</a></p>"
    end

    #prepare credit card receipt
    if params[:CCR]
      @credit_card_receipt = ""
      if !@master_transactions.empty?
        @credit_card_receipt << render_to_string(:partial => "transactions/credit_card_receipt", :locals => {:transaction => @master_transactions, :type => "MasterCard"})
      end
      if !@master_transactions.empty? && !@visa_transactions.empty?
        @credit_card_receipt << "<div class=\"page_break\">&nbsp;</div>"
      end
      if !@visa_transactions.empty?
        @credit_card_receipt << render_to_string(:partial => "transactions/credit_card_receipt", :locals => {:transaction => @visa_transactions, :type => "VisaCard"})
      end
      File.open("#{file_prefix}/#{file_dir}/#{@run.id}-CreditCardReceipt.html", 'w') do |f|
        f.puts "#{@credit_card_receipt}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-CreditCardReceipt.html #{file_prefix}/#{file_dir}/#{@run.id}-CreditCardReceipt.pdf; rm #{file_prefix}/#{file_dir}/#{@run.id}-CreditCardReceipt.html"
      flash[:comfirmation] << "<p>CreditCardReceipt: <a href=\'/#{file_dir}/#{@run.id}-CreditCardReceipt.pdf\'>#{@run.id}-CreditCardReceipt.pdf</a></p>"
    end
    
    #prepare receipt account summary
    if params[:RAS]
      @receipt_account_summary = render_to_string(:partial => "transactions/receipt_account_summary")
      File.open("#{file_prefix}/#{file_dir}/#{@run.id}-ReceiptAccountSummary.html", 'w') do |f|
        f.puts "#{@receipt_account_summary}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptAccountSummary.html #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptAccountSummary.pdf; rm #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptAccountSummary.html"
      flash[:comfirmation] << "<p>ReceiptAccountSummary: <a href=\'/#{file_dir}/#{@run.id}-ReceiptAccountSummary.pdf\'>#{@run.id}-ReceiptAccountSummary.pdf</a></p>"
    end
    
    #prepare receipt type summary
    if params[:RTS]
      @receipt_type_summary = render_to_string(:partial => "transactions/receipt_type_summary")
      File.open("#{file_prefix}/#{file_dir}/#{@run.id}-ReceiptTypeSummary.html", 'w') do |f|
        f.puts "#{@receipt_type_summary}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptTypeSummary.html #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptTypeSummary.pdf; rm #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptTypeSummary.html"
      flash[:comfirmation] << "<p>ReceiptTypeSummary: <a href=\'/#{file_dir}/#{@run.id}-ReceiptTypeSummary.pdf\'>#{@run.id}-ReceiptTypeSummary.pdf</a><p>"
    end
  end
      
end