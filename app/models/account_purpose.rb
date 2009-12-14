class AccountPurpose < AmazonSetting


 def self.active_account_purpose_type
    @account_purpose_type = AccountPurpose.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end
  

end
