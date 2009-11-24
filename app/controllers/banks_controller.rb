class BanksController < ApplicationController


  def list
    @banks = Bank.find(:all, :order => "id ASC")

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

  def refresh_existing_banks
    @banks = Bank.find(:all, :order => "id ASC")
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

  def edit_bank_entry
    @bank_to_update = Bank.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @bank = Bank.find_by_id(params[:id])
    if @bank.update_attributes(params[:bank_update])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Bank with ID #{@bank.id}.")
    else
      flash[:error] = flash_message(:type => "field_missing", :field => "#{@bank.errors.first.first.humanize}")
    end
    respond_to do |format|
      format.js
    end
  end

end
