class BanksController < ApplicationController


  def list
    @banks = Bank.find(:all)

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
    @banks = Bank.find(:all)
    respond_to do |format|
      format.js
    end
  end

  def delete_bank_entry
    puts "*********** DELETING Bank with id #{params[:id]}"
    @bank = Bank.find_by_id(params[:id])
    puts "*********** Found Bank #{@bank.to_yaml}"
    @bank.destroy if !@bank.nil?
    respond_to do |format|
      format.js
    end
  end

end
