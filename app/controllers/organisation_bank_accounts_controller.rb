class OrganisationBankAccountsController < ApplicationController

    def show
    @organisation_bank_account = OrganisationBankAccount.find(params[:id].to_i)

    respond_to do |format|
      format.js
    end
  end


   def create

    @entity = Organisation.find(params[:organisation_id].to_i)
    @organisation_bank_accounts = @entity.organisation_bank_accounts.new(params[:organisation_bank_account])


   if @organisation_bank_accounts.save
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Organisation Account #{@entity.id}.")
   else

      flash.now[:error]= flash_message(:type => "uniqueness_error", :field => "Bank Account")if(!@organisation_bank_accounts.errors[:account_number].nil? && @organisation_bank_accounts.errors.on(:account_number).include?("has already been taken"))
   end
    respond_to do |format|
      format.js
    end

  end



   def edit
    @bank_accounts = OrganisationBankAccount.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end


    def update
    @organisation_bank_account = OrganisationBankAccount.find(params[:id].to_i)
    if @organisation_bank_account.update_attributes(params[:organisation_bank_account]["#{@organisation_bank_account.id}"])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) edited Person Bank Account #{@organisation_bank_account.id}.")
    else
      flash.now[:error]= "Please Enter All Required Data"if(!@organisation_bank_account.errors[:account_number].nil? && @organisation_bank_account.errors.on(:account_number).include?("can't be blank"))
    end
      respond_to do |format|
        format.js {render 'show.js'}
      end

  end

      def destroy

    @organisation_bank_account = OrganisationBankAccount.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted #{@organisation_bank_account.id}.")
    @organisation_bank_account.destroy

    respond_to do |format|
      format.js
    end
  end
end
