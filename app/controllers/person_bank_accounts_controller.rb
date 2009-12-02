class PersonBankAccountsController < ApplicationController

 def create

    @entity = Person.find(params[:person_id].to_i)
    @person_bank_accounts = @entity.person_bank_accounts.new(params[:person_bank_account])


   if @person_bank_accounts.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Person Account #{@entity.id}.")
   else
      
      flash.now[:error]= flash_message(:type => "uniqueness_error", :field => "Bank Account")if(!@person_bank_accounts.errors[:account_number].nil? && @person_bank_accounts.errors.on(:account_number).include?("has already been taken"))
   end



    respond_to do |format|
      format.js
    end

  end
  
end
