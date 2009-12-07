class PersonBankAccountsController < ApplicationController


    def show
    @person_bank_account = PersonBankAccount.find(params[:id].to_i)

    respond_to do |format|
      format.js
    end
  end

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


   def edit
    @bank_accounts = PersonBankAccount.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end


    def update
    @person_bank_account = PersonBankAccount.find(params[:id].to_i)
    if @person_bank_account.update_attributes(params[:person_bank_account]["#{@person_bank_account.id}"])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) edited Person Bank Account #{@person_bank_account.id}.")
    else
      flash.now[:error]= "Please Enter All Required Data"if(!@person_bank_account.errors[:account_number].nil? && @person_bank_account.errors.on(:account_number).include?("can't be blank"))
    end
      respond_to do |format|
        format.js {render 'show.js'}
      end

  end



   def destroy

    @person_bank_account = PersonBankAccount.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted #{@person_bank_account.id}.")
    @person_bank_account.destroy

    respond_to do |format|
      format.js
    end
  end


  
end
