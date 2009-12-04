class TransactionsController < ApplicationController
  # System Log stuff added

  def personal_transaction
    @group_types = LoginAccount.find(session[:user]).group_types
    @list_headers = @current_user.all_lists
    @list_header = ListHeader.find(session[:current_list_id])
    @p = @list_header.people_on_list
    @person = Person.find(session[:current_person_id])
    respond_to do |format|
      format.html
    end
  end

  def organisational_transaction    
    @organisation = Organisation.find(session[:current_organisation_id])
    @o = Organisation.find(:all, :order => "id")
    respond_to do |format|
      format.html
    end
  end

  def new
    @system_date = session[:clocktime].strftime("%d-%m-%Y")
    @transaction_header = TransactionHeader.new
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
    if @transaction_header.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new transaction with ID #{@transaction_header.id}.")
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

      end

    end

  end
