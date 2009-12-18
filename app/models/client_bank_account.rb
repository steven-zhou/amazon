class ClientBankAccount < BankAccount

 belongs_to :bank
 belongs_to :account_purpose

  def self.active_client_bank_account
    @client_bank_account = ClientBankAccount.find(:all, :conditions => ["status = true"], :order => 'account_number')
  end


end
