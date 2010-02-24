puts "Destroy Account Purpose ..."
AccountPurpose.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless BankAccount.find_by_account_purpose_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end



puts "Destroy Account Type ..."
AccountType.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless BankAccount.find_by_account_type_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end


puts "Destroy Title ..."
Title.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless (Person.find_by_primary_title_id(i.id).nil?  and Person.find_by_second_title_id(i.id).nil?)
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "Destroy Gender ..."
Gender.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Person.find_by_gender_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "Destroy IndustrySector ..."
IndustrySector.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Organisation.find_by_industry_sector_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end


puts "Destroy Address Type ..."
AddressType.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Address.find_by_address_type_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "Destroy Note Type ..."
NoteType.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Note.find_by_note_type_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "Destroy Marital Status ..."
MaritalStatus.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Person.find_by_marital_status_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "Destroy Department ..."
Department.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Employment.find_by_department_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "Destroy Section ..."
Section.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Employment.find_by_section_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "Destroy Cost Centre ..."
CostCentre.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Employment.find_by_cost_centre_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end


puts "Destroy Position Type ..."
PositionTitle.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Employment.find_by_position_title_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "Destroy Position Classification ..."
PositionClassification.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Employment.find_by_position_classification_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end


puts "Destroy Position Type ..."
PositionType.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Employment.find_by_position_type_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "Destroy Award Agreement ..."
AwardAgreement.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Employment.find_by_position_type_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end


puts "Destroy Postition Status ..."
PositionStatus.find(:all,:conditions=>["to_be_removed = true"]).each do |i|

  unless Employment.find_by_position_type_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy payment frequency ..."
PaymentFrequency.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  unless Employment.find_by_payment_frequency_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy payment method ..."
PaymentMethod.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  unless Employment.find_by_payment_method_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy suspension type ..."
SuspensionType.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  unless Employment.find_by_suspension_type_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy termination method ..."
TerminationMethod.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  unless Employment.find_by_termination_method_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy organisation type ..."
OrganisationType.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  unless Organisation.find_by_organisation_type_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy payment day ..."
PaymentDay.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  unless Employment.find_by_payment_day_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end


puts "destroy security question ..."
SecurityQuestion.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  if (LoginAccount.find_by_security_question1_id(i.id).nil? && LoginAccount.find_by_security_question2_id(i.id).nil? && LoginAccount.find_by_security_question3_id(i.id).nil?)
    i.destroy
  else
    i.to_be_removed = false
    i.save
  end
end

puts "destroy business category ..."
BusinessCategory.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  unless Organisation.find_by_business_category_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy link module ..."
LinkModule.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  unless ReceiptAccount.find_by_link_module_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "destroy received via ..."
ReceivedVia.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  unless TransactionHeader.find_by_received_via_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end






puts "Destroy Keyword ..."
Keyword.find(:all,:conditions=>["to_be_removed = true"]).each do |i|
  unless KeywordLink.find_by_keyword_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end

puts "Destroy KeywordType ..."
KeywordType.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  i.destroy  
end

puts "Destroy Role ..."
Role.find(:all,:conditions=>["to_be_removed = true"]).each do |i|
  unless PersonRole.find_by_role_id(i.id).nil?
    i.to_be_removed = false
    i.save
  else
    i.destroy
  end
end


puts "Destroy RoleType ..."
RoleType.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  i.destroy
end

puts "Destroy Mail Merge Category ..."
MailMergeCategory.find(:all,:conditions => ["to_be_removed = true"]).each do |i|
  i.destroy
end
