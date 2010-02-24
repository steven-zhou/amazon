puts "destroy custom groups ..."
custom_group = GroupMetaMetaType.find_custom_group
customer_group_children = GroupMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", custom_group.id])
customer_group_children.each do |c|
  GroupType.find(:all, :conditions => ["tag_type_id = ? AND to_be_removed = true", c.id]).each do |i|
    if PersonGroup.find_by_tag_id(i.id).nil?
      i.destroy
    else
      i.to_be_removed = false
      i.save
    end
  end
end

puts "destroy security groups ..."
security_group = GroupMetaMetaType.find_security_group
security_group_children = GroupMetaType.find(:all, :conditions => ["tag_meta_type_id = ?", security_group.id])
security_group_children.each do |s|
  GroupType.find(:all, :conditions => ["tag_type_id = ? AND to_be_removed = true", s.id]).each do |i|
    if UserGroup.find_by_group_id(i.id).nil?
      i.destroy
    else
      i.to_be_removed = false
      i.save
    end
  end
end

GroupMetaType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  i.destroy
end

puts "destroy masterdoc type ..."
MasterDocType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  if MasterDoc.find_by_master_doc_type_id(i.id).nil?
    i.destroy
  else
    i.to_be_removed = false
    i.save
  end
end

MasterDocMetaType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  i.destroy
end

MasterDocMetaMetaType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  i.destroy
end

puts "destroy contact meta type ..."
ContactMetaType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  if Contact.find_by_contact_meta_type_id(i.id).nil?
    i.destroy
  else
    i.to_be_removed = false
    i.save
  end
end

puts "destroy receipt meta type ..."
ReceiptMetaType.find(:all, :conditions => ["to_be_removed = true"]).each do |i|
  if TransactionHeader.find_by_receipt_type_id(i.id).nil?
    i.destroy
  else
    i.to_be_removed = false
    i.save
  end
end