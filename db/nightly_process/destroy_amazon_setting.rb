AccountPurpose.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  if BankAccount.find_by_account_purpose_id(i.id)
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end

end