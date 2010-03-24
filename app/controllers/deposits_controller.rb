class DepositsController < ApplicationController
  # System Log stuff added

  include OutputPdf
  
  def new
    @system_date = session[:clocktime_date]
    @deposit = Deposit.new
    @cheque_detail = ChequeDetail.new
    @credit_card_detail = CreditCardDetail.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @deposit = Deposit.find(params[:id])
    @cheque_detail = @deposit.cheque_detail rescue @cheque_detail = ChequeDetail.new
    @credit_card_detail = @deposit.credit_card_detail rescue @credit_card_detail = CreditCardDetail.new
    @receipts = @deposit.receipts
    respond_to do |format|
      format.js
    end
  end

  def create
    @deposit = Deposit.new(params[:deposit])
    @deposit.entity_type = session[:entity_type]
    @deposit.entity_id = session[:entity_id]
    @deposit.post = false
    Deposit.transaction do
      if @deposit.save
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new deposit with ID #{@deposit.id}.")
        #save deposit detail
        @deposit_detail = case @deposit.payment_method_meta_type.name
        when "Cheque" then ChequeDetail.new(params[:deposit_detail])
        when "Credit Card" then CreditCardDetail.new(params[:deposit_detail])
        end
        #cash is not implemented
        unless @deposit.payment_method_meta_type.name == "Cash"
          @deposit_detail.deposit_id = @deposit.id
          @deposit_detail.save
        end      
        @deposit.update_attribute("receipt_number", @deposit.id)

      else
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to create a new deposit record.")
        #----------------------------presence - of--------------------
        if(!@deposit.errors[:deposit_date].nil? && @deposit.errors.on(:deposit_date).include?("can't be blank"))
          flash.now[:error] = "Please make sure the deposit date is entered in valid format (dd-mm-yyyy)"
        elsif(!@deposit.errors[:deposit_date].nil? && @deposit.errors.on(:deposit_date).include?("is invalid"))
          flash.now[:error] = "Please make sure the deposit date is entered in valid format (dd-mm-yyyy)"
        elsif(!@deposit.errors[:bank_account_id].nil? && @deposit.errors.on(:bank_account_id).include?("can't be blank"))
          flash.now[:error] = "Please Enter All Required Data"
        elsif(!@deposit.errors[:receipt_meta_type_id].nil? && @deposit.errors.on(:receipt_meta_type_id).include?("can't be blank"))
          flash.now[:error] = "Please Enter All Required Data"
        elsif(!@deposit.errors[:receipt_type_id].nil? && @deposit.errors.on(:receipt_type_id).include?("can't be blank"))
          flash.now[:error] = "Please Enter All Required Data"
        elsif(!@deposit.errors[:received_via_id].nil? && @deposit.errors.on(:received_via_id).include?("can't be blank"))
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
    @deposit = Deposit.find(params[:id])
    Deposit.transaction do
      if @deposit.update_attributes(params[:deposit])
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated the details for Deposit with ID #{@deposit.id}.")

        #update deposit type detail
        if @deposit.payment_method_meta_type.name + ' Detail' == @deposit.deposit_detail.class.to_s.titleize
          #if receipt meta meta type is not changed
          @deposit_detail = @deposit.deposit_detail
          @deposit_detail.update_attributes(params[:deposit_detail])
        else
          #else receipt meta meta type is changed, destroy old detail and create a new one
          @deposit_detail_old = @deposit.deposit_detail
          @deposit_detail_old.destroy unless @deposit_detail_old.nil?
          @deposit_detail = case @deposit.payment_method_meta_type.name
          when "Cheque" then ChequeDetail.new(params[:deposit_detail])
          when "Credit Card" then CreditCardDetail.new(params[:deposit_detail])
          end

          #cash is not implemented
          unless @deposit.payment_method_meta_type.name == "Cash"
            @deposit_detail.deposit_id = @deposit.id
            @deposit_detail.save!
          end
        end
      else
        system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) had an error when attempting to update a deposit header record.")
        #----------------------------presence - of------------------
        if(!@deposit.errors[:deposit_date].nil? && @deposit.errors.on(:deposit_date).include?("can't be blank"))
          flash.now[:error] = "Please make sure the deposit date is entered in valid format (dd-mm-yyyy)"
        elsif(!@deposit.errors[:deposit_date].nil? && @deposit.errors.on(:deposit_date).include?("is invalid"))
          flash.now[:error] = "Please make sure the deposit date is entered in valid format (dd-mm-yyyy)"
        elsif(!@deposit.errors[:bank_account_id].nil? && @deposit.errors.on(:bank_account_id).include?("can't be blank"))
          flash.now[:error] = "Please Enter All Required Data"
        elsif(!@deposit.errors[:receipt_meta_type_id].nil? && @deposit.errors.on(:receipt_meta_type_id).include?("can't be blank"))
          flash.now[:error] = "Please Enter All Required Data"
        elsif(!@deposit.errors[:receipt_type_id].nil? && @deposit.errors.on(:receipt_type_id).include?("can't be blank"))
          flash.now[:error] = "Please Enter All Required Data"
        elsif(!@deposit.errors[:received_via_id].nil? && @deposit.errors.on(:received_via_id).include?("can't be blank"))
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
    @deposit = depositHeader.find(params[:id])
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
      @count = depositHeader.count(:all, :conditions => ["entity_id=? and entity_type=? and banked=? and deposit_date >= ? and deposit_date <= ?", session[:entity_id], session[:entity_type], true, @start_date.to_date, @end_date.to_date])
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
        params[:start_id] = depositHeader.first_record.id.to_s if params[:start_id].blank?
        params[:end_id] =   depositHeader.last_record.id.to_s if params[:end_id].blank?
        conditions << ("start_id=" + params[:start_id].to_i.to_s)
        conditions << ("end_id=" + params[:end_id].to_i.to_s)
      end

      if (!params[:start_receipt_id].blank? || !params[:end_receipt_id].blank?)
        params[:start_receipt_id] = depositHeader.first_record.receipt_number.to_s if params[:start_receipt_id].blank?
        params[:end_receipt_id] = depositHeader.last_record.receipt_number.to_s if params[:end_receipt_id].blank?
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

      if valid_date(params[:start_deposit_date]) && valid_date(params[:end_deposit_date])
        if (!params[:start_deposit_date].blank? || !params[:end_deposit_date].blank?)
          params[:start_deposit_date] = "01-01-#{Date.today().year().to_s}"if params[:start_deposit_date].blank?
          params[:end_deposit_date] = "31-12-#{Date.today().year().to_s}"if params[:end_deposit_date].blank?
          conditions << ("start_deposit_date=" + params[:start_deposit_date])
          conditions << ("end_deposit_date=" + params[:end_deposit_date])
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

      if (params[:payment_method_meta_type_id] && params[:payment_method_meta_type_id]!= "0")
        conditions << ("payment_method_meta_type_id=" + params[:payment_method_meta_type_id])
      end

      if (params[:payment_method_type_id] && params[:payment_method_type_id]!= "0")
        conditions << ("payment_method_type_id=" + params[:payment_method_type_id])
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
        @count = depositHeader.count(:all, :conditions => ["entity_id=? and entity_type=? and deposit_date >= ? and deposit_date <= ?", session[:entity_id], session[:entity_type], @start_date.to_date, @end_date.to_date])
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
    @file_name = params[:file_name].blank? ? "deposit histroy" : params[:file_name]
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) exported a deposit histroy report.")
    respond_to do |format|
      format.pdf {pdf = PDF::Writer.new
        pdf = OutputPdf.generate_deposit_histroy_report_pdf(session[:entity_type], session[:entity_id], params[:start_date], params[:end_date], {}, {})
        send_data(pdf.render, :filename => "#{@file_name}.pdf", :type => "application/pdf")}
    end
  end

  def destroy
    @deposit = depositHeader.find(params[:id].to_i)
    @deposit.destroy
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) destroy a deposit header record with id #{params[:id]}.")
    respond_to do |format|
      format.js
    end
  end

  def enquiry_show_receipt_type
    @payment_method_type = PaymentMethodMetaType.find(params[:param1])rescue  @payment_method_type = PaymentMethodMetaType.new
    if params[:param1] != "0"
      @payment_methods = PaymentMethodType.find(:all, :conditions => ['tag_type_id = ? AND status = true AND to_be_removed = false', params[:param1]])
      @options = ""
      @options += "<option value = 0 >All"
      @payment_methods.each do |i|
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
      params[:start_id] = depositHeader.first_record.id.to_s if params[:start_id].blank?
      params[:end_id] = depositHeader.last_record.id.to_s if params[:end_id].blank?
      conditions << "id BETWEEN ? AND ?"
      values << params[:start_id].to_i.to_s
      values << params[:end_id].to_i.to_s
    end

    if (params[:user_id]&&params[:user_id]!="All")
      conditions << "creator_id = ?"
      values << params[:user_id].to_i
    end

    if (params[:start_deposit_date] || params[:end_deposit_date])
      params[:start_deposit_date] = "01-01-#{Date.today().year().to_s}"if params[:start_deposit_date].blank?
      params[:end_deposit_date] = "31-12-#{Date.today().year().to_s}"if params[:end_deposit_date].blank?
      if valid_date(params[:start_deposit_date]) && valid_date(params[:end_deposit_date])
        conditions << "deposit_date BETWEEN ? AND ?"
        values << params[:start_deposit_date].to_date
        values << params[:end_deposit_date].to_date
      else
        @date_valid = false
        flash[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
      end
    end
    
    @deposits = depositHeader.find(:all, :conditions => [conditions.join(" AND "), *values])
    
    if @deposits.blank?
      flash[:warning] = "No outstanding deposits found"
    elsif !@date_valid
      flash[:warning] = "Invalid date"
      
    else
      #new Bank Run
      @run = BankRun.new
      BankRun.deposit do
        @run.save
        @deposits.each do |i|
          i.bank_run_id = @run.id
          i.banked = true
          i.save
        end
      end
      flash[:confirmation] = "<p>Reports are generated and available here:</p>"
      prepare_bank_run_report(@run.id)
    end

    redirect_to :controller => "deposits", :action => "bank_run"
  end

  def prepare_bank_run_report(bank_run_id)
    @client = ClientOrganisation.first
    @run = BankRun.find(bank_run_id)
    @date = @run.created_at.getlocal.strftime('%d-%m-%Y')
    @time =  @run.created_at.getlocal.strftime('%I:%m%p')
    @deposits = depositHeader.find(:all, :conditions => ["bank_run_id = ?", bank_run_id])
    @accounts = Array.new
    @cash_deposits = Array.new
    @cheque_deposits = Array.new

    # for bank run audit sheet or credit cards receipt
    if params[:BRAS] || params[:CCR]
      @master_deposits = Array.new
      @visa_deposits = Array.new
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
    
    
    
    
    @deposits.each do |i|
      bank_account = i.bank_account
      payment_method_meta_type = i.payment_method_meta_type.try(:name)
      payment_method_type = i.payment_method_type.try(:name)
      @accounts << bank_account unless @accounts.include?(bank_account)

      if payment_method_meta_type == "Cash"
        @cash_deposits[bank_account.id] << i rescue @cash_deposits[bank_account.id]=[i]
      end
      if payment_method_meta_type == "Cheque"
        @cheque_deposits[bank_account.id] << i rescue @cheque_deposits[bank_account.id]=[i]
      end

      # for bank run audit sheet or credit cards receipt
      if params[:BRAS] || params[:CCR]
        if payment_method_meta_type == "Credit Card"
          if payment_method_type == "Master Card"
            @master_deposits[bank_account.id] << i rescue @master_deposits[bank_account.id]=[i]
          elsif payment_method_type == "Visa Card"
            @visa_deposits[bank_account.id] << i rescue @visa_deposits[bank_account.id]=[i]
          end
        end
      end

      # for receipt account summary
      if params[:RAS]
        @receipt_account.each do |receipt_account|
          i.deposit_allocations.each do |deposit_allocation|
            if deposit_allocation.receipt_account.name == receipt_account.name
              if deposit_allocation.deposit.payment_method_meta_type.name == "Cash"
                @receipt_account_cash[bank_account.id+receipt_account.id] << deposit_allocation.amount rescue @receipt_account_cash[bank_account.id+receipt_account.id] = [deposit_allocation.amount]
              elsif deposit_allocation.deposit.payment_method_meta_type.name == "Cheque"
                @receipt_account_cheque[bank_account.id+receipt_account.id] <<deposit_allocation.amount rescue @receipt_account_cheque[bank_account.id+receipt_account.id] = [deposit_allocation.amount]
              elsif deposit_allocation.deposit.payment_method_meta_type.name == "Credit Card"
                @receipt_account_cards[bank_account.id+receipt_account.id] <<deposit_allocation.amount rescue @receipt_account_cards[bank_account.id+receipt_account.id] = [deposit_allocation.amount]
              end
            end
          end
        end
      end

      # for receipt type summary
      if params[:RTS]
        i.deposit_allocations.each do |deposit_allocation|
          if deposit_allocation.deposit.payment_method_meta_type.name == "Cash"
            @receipt_type_cash[bank_account.id] << deposit_allocation.amount rescue @receipt_type_cash[bank_account.id]  = [deposit_allocation.amount]
          elsif deposit_allocation.deposit.payment_method_meta_type.name == "Cheque"
            @receipt_type_cheque[bank_account.id] <<deposit_allocation.amount rescue @receipt_type_cheque[bank_account.id] = [deposit_allocation.amount]
          elsif deposit_allocation.deposit.payment_method_type.name == "Master Card"
            @receipt_type_master_cards[bank_account.id] << deposit_allocation.amount rescue @receipt_type_master_cards[bank_account.id] = [deposit_allocation.amount]
          elsif deposit_allocation.deposit.payment_method_type.name == "Visa Card"
            @receipt_type_visa_cards[bank_account.id] << deposit_allocation.amount rescue @receipt_type_visa_card[bank_account.id] = [deposit_allocation.amount]
          end
        end
      end


      #for bank run campaign summary
      if params[:CS]
        @campaign.each do |campaign|
          i.deposit_allocations.each do |deposit_allocation|
            if deposit_allocation.campaign.try(:name) == campaign.name
              if deposit_allocation.deposit.payment_method_meta_type.name == "Cash"
                @campaign_cash[bank_account.id+campaign.id] << deposit_allocation.amount rescue @campaign_cash[bank_account.id+campaign.id] = [deposit_allocation.amount]
              elsif deposit_allocation.deposit.payment_method_meta_type.name == "Cheque"
                @campaign_cheque[bank_account.id+campaign.id] <<deposit_allocation.amount rescue @campaign_cheque[bank_account.id+campaign.id] = [deposit_allocation.amount]
              elsif deposit_allocation.deposit.payment_method_meta_type.name == "Credit Card"
                @campaign_cards[bank_account.id+campaign.id] <<deposit_allocation.amount rescue @campaign_cards[bank_account.id+campaign.id] = [deposit_allocation.amount]
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

    #pdf header and footer
    now = Time.now.strftime("%A %d %B %Y %H:%M:%S")
    pdf_options = "--page-size A4 --header-center MemberZone --header-right 'Page [page] of [toPage]' --footer-center 'Copyright MemberZone Pty Ltd - Generated at #{now}'"

    #prepare bank deposit sheet

    @bank_deposit_sheet = render_to_string(:partial => "deposits/bank_deposit_sheet")
    File.open("#{file_prefix}/#{file_dir}/#{@run.id}-BankDepositSheet.html", 'w') do |f|
      f.puts "#{@bank_deposit_sheet}"
    end
    system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-BankDepositSheet.html #{file_prefix}/#{file_dir}/#{@run.id}-BankDepositSheet.pdf #{pdf_options}; rm #{file_prefix}/#{file_dir}/#{@run.id}-BankDepositSheet.html"
    flash[:confirmation] << "<p>BankDepositSheet: <a href=\'/#{file_dir}/#{@run.id}-BankDepositSheet.pdf\' target='_blank'>#{@run.id}-BankDepositSheet.pdf</a></p>"


    #prepare bank run audit sheet
    if params[:BRAS]
      @bank_run_audit_sheet = render_to_string(:partial => "deposits/bank_run_audit_sheet")
      File.open("#{file_prefix}/#{file_dir}/#{@run.id}-BankRunAuditSheet.html", 'w') do |f|
        f.puts "#{@bank_run_audit_sheet}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-BankRunAuditSheet.html #{file_prefix}/#{file_dir}/#{@run.id}-BankRunAuditSheet.pdf #{pdf_options}; rm #{file_prefix}/#{file_dir}/#{@run.id}-BankRunAuditSheet.html"
      flash[:confirmation] << "<p>BankRunAuditSheet: <a href=\'/#{file_dir}/#{@run.id}-BankRunAuditSheet.pdf\' target='_blank'>#{@run.id}-BankRunAuditSheet.pdf</a></p>"
    end
    
    #prepare bank run campaign summary
    if params[:CS]
      @bank_run_campaign_summary = render_to_string(:partial => "deposits/bank_run_campaign_summary")
      File.open("#{file_prefix}/#{file_dir}/#{@run.id}-BankRunCampaignSummary.html", 'w') do |f|
        f.puts "#{@bank_run_campaign_summary}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-BankRunCampaignSummary.html #{file_prefix}/#{file_dir}/#{@run.id}-BankRunCampaignSummary.pdf #{pdf_options}; rm #{file_prefix}/#{file_dir}/#{@run.id}-BankRunCampaignSummary.html"
      flash[:confirmation] << "<p>BankRunCampaignSummary: <a href=\'/#{file_dir}/#{@run.id}-BankRunCampaignSummary.pdf\' target='_blank'>#{@run.id}-BankRunCampaignSummary.pdf</a></p>"
    end

    #prepare credit card receipt
    if params[:CCR]
      @credit_card_receipt = ""
      if !@master_deposits.empty?
        @credit_card_receipt << render_to_string(:partial => "deposits/credit_card_receipt", :locals => {:deposit => @master_deposits, :type => "MasterCard"})
      end
      if !@master_deposits.empty? && !@visa_deposits.empty?
        @credit_card_receipt << "<div class=\"page_break\">&nbsp;</div>"
      end
      if !@visa_deposits.empty?
        @credit_card_receipt << render_to_string(:partial => "deposits/credit_card_receipt", :locals => {:deposit => @visa_deposits, :type => "VisaCard"})
      end
      File.open("#{file_prefix}/#{file_dir}/#{@run.id}-CreditCardReceipt.html", 'w') do |f|
        f.puts "#{@credit_card_receipt}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-CreditCardReceipt.html #{file_prefix}/#{file_dir}/#{@run.id}-CreditCardReceipt.pdf #{pdf_options}"
      flash[:confirmation] << "<p>CreditCardReceipt: <a href=\'/#{file_dir}/#{@run.id}-CreditCardReceipt.pdf\' target='_blank'>#{@run.id}-CreditCardReceipt.pdf</a></p>"
    end
    
    #prepare receipt account summary
    if params[:RAS]
      @receipt_account_summary = render_to_string(:partial => "deposits/receipt_account_summary")
      File.open("#{file_prefix}/#{file_dir}/#{@run.id}-ReceiptAccountSummary.html", 'w') do |f|
        f.puts "#{@receipt_account_summary}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptAccountSummary.html #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptAccountSummary.pdf #{pdf_options}; rm #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptAccountSummary.html"
      flash[:confirmation] << "<p>ReceiptAccountSummary: <a href=\'/#{file_dir}/#{@run.id}-ReceiptAccountSummary.pdf\' target='_blank'>#{@run.id}-ReceiptAccountSummary.pdf</a></p>"
    end
    
    #prepare receipt type summary
    if params[:RTS]
      @receipt_type_summary = render_to_string(:partial => "deposits/receipt_type_summary")
      File.open("#{file_prefix}/#{file_dir}/#{@run.id}-ReceiptTypeSummary.html", 'w') do |f|
        f.puts "#{@receipt_type_summary}"
      end
      system "wkhtmltopdf #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptTypeSummary.html #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptTypeSummary.pdf #{pdf_options}; rm #{file_prefix}/#{file_dir}/#{@run.id}-ReceiptTypeSummary.html"
      flash[:confirmation] << "<p>ReceiptTypeSummary: <a href=\'/#{file_dir}/#{@run.id}-ReceiptTypeSummary.pdf\' target='_blank'>#{@run.id}-ReceiptTypeSummary.pdf</a><p>"
    end
  end


end