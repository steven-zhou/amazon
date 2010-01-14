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
    params[:start_date] ||= "01-01-#{Date.today().year().to_s}"
    params[:end_date] ||= "31-12-#{Date.today().year().to_s}"
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    date_regex = /^(((0[1-9]|[12]\d|3[01])\-(0[13578]|1[02])\-((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\-(0[13456789]|1[012])\-((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\-02\-((19|[2-9]\d)\d{2}))|(29\-02\-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/
    if !(@start_date =~ date_regex).nil? && !(@end_date =~ date_regex).nil?
      @count = TransactionHeader.count(:all, :conditions => ["entity_id=? and entity_type=? and banked=? and transaction_date >= ? and transaction_date <= ?", session[:entity_id], session[:entity_type], true, @start_date.to_date, @end_date.to_date])
      @date_valid = true
    else
      @date_valid = false
      flash.now[:error] = "Please make sure the start date and end date are entered in valid format (dd-mm-yyyy)"
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
end
