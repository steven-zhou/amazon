puts "destroy receipt account"
ReceiptAccount.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  if TransactionAllocation.find_by_receipt_account_id(i.id).nil?
    i.destroy
  else
    i.to_be_removed = false
    i.save
  end
end

puts "destroy campaign"
Campaign.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  if TransactionAllocation.find_by_campaign_id(i.id).nil?
    i.destroy
  else
    i.to_be_removed = false
    i.save
  end
end

puts "destroy source"
Source.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  if TransactionAllocation.find_by_source_id(i.id).nil?
    i.destroy
  else
    i.to_be_removed = false
    i.save
  end
end

puts "destroy client bank account"
ClientBankAccount.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  if TransactionHeader.find_by_bank_account_id(i.id).nil?
    i.destroy
  else
    i.to_be_removed = false
    i.save
  end
end

puts "destroy message template"
MessageTemplate.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  i.destroy
end