class BanksController < ApplicationController


  def list
    @banks = Bank.all
  end

  def create
    @bank = Bank.new(params[:bank])
    if @bank.save
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created a new Bank with ID #{@bank.id}.")
    else
      flash[:error] = flash_message(:type => "field_missing", :field => "#{@bank.errors.first.first.humanize}")
    end
    respond_to do |format|
      format.js
    end
  end


  def delete_bank_entry
    @bank = Bank.find_by_id(params[:id])
    @bank.destroy if !@bank.nil?
    respond_to do |format|
      format.js
    end
  end

  def edit
    @bank_to_update = Bank.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @bank = Bank.find_by_id(params[:id])
    if @bank.update_attributes(params[:bank])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Bank with ID #{@bank.id}.")
    else
      flash[:error] = flash_message(:type => "field_missing", :field => "#{@bank.errors.first.first.humanize}")
    end
    respond_to do |format|
      format.js
    end
  end

  
  def name_finder
    @bank = Bank.find_by_id(params[:bank_id]) rescue @bank = Bank.new
    @bank = Bank.new if @bank.nil?
    @account = PersonBankAccount.find(params[:account_id].to_i) rescue @account = PersonBankAccount.new
    if @account.new_record?
      @account = OrganisationBankAccount.find(params[:account_id].to_i) rescue @account = OrganisationBankAccount.new
    end
    @input_field_id = params[:input_field_id]  #to clear the input field
    respond_to do |format|
      format.js {  }
    end
  end


  def lookup  #  look up bank in the list
    @update_field = params[:update_field]
    respond_to do |format|
      format.js
    end
  end

  def lookup_fill
    @update_field = params[:update_field]
    @bank = Bank.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end

end
