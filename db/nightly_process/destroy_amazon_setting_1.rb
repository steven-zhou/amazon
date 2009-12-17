puts "destroy payment frequency"
PaymentFrequency.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  if Employment.find_by_payment_frequency_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy payment method"
PaymentMethod.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  if Employment.find_by_payment_method_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy suspension type"
SuspensionType.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  if Employment.find_by_suspension_type_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy termination method"
TerminationMethod.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  if Employment.find_by_termination_method_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy organisation type"
OrganisationType.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  if Organisation.find_by_organisation_type_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy security question"
SecurityQuestion.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  if (LoginAccount.find_by_security_question1_id(i.id).nil? && LoginAccount.find_by_security_question2_id(i.id).nil? && LoginAccount.find_by_security_question3_id(i.id).nil?)
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy business category"
BusinessCategory.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  if Organisation.find_by_business_category_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy link module"
LinkModule.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  if ReceiptAccount.find_by_link_module_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy received via"
ReceivedVia.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  if TransactionHeader.find_by_received_via_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end