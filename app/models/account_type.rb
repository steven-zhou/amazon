class AccountType < AmazonSetting
 def self.active_account_type
    @account_type = AccountType.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end


end
