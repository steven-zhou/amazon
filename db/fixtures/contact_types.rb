puts "Initializing Contact Type"
ContactMetaMetaType.create :name => "Email",    :status => true
ContactMetaMetaType.create :name => "Phone",    :status => true
ContactMetaMetaType.create :name => "Website",    :status => true
ContactMetaMetaType.create :name => "IM",    :status => true

email = ContactMetaMetaType.find_by_name("Email")
phone = ContactMetaMetaType.find_by_name("Phone")
website = ContactMetaMetaType.find_by_name("Website")
im = ContactMetaMetaType.find_by_name("IM")

ContactMetaType.create :name => "Work",   :tag_meta_type_id => email.id,    :status => true
ContactMetaType.create :name => "Personal",   :tag_meta_type_id => email.id,    :status => true
ContactMetaType.create :name => "Mobile",   :tag_meta_type_id => phone.id,    :status => true
ContactMetaType.create :name => "Home",   :tag_meta_type_id => phone.id,    :status => true
ContactMetaType.create :name => "Fax",   :tag_meta_type_id => phone.id,    :status => true
ContactMetaType.create :name => "Business",   :tag_meta_type_id => website.id,    :status => true
ContactMetaType.create :name => "Facebook",   :tag_meta_type_id => im.id,    :status => true


puts "Initializing Receipt Types"
ReceiptMetaMetaType.create :name => "Credit Card",    :status => true
ReceiptMetaMetaType.create :name => "Cash",    :status => true
ReceiptMetaMetaType.create :name => "Cheque",    :status => true


credit_card = ReceiptMetaMetaType.find_by_name("Credit Card")
cash = ReceiptMetaMetaType.find_by_name("Cash")
cheque = ReceiptMetaMetaType.find_by_name("Cheque")


ReceiptMetaType.create :name => "Visa Card",   :tag_meta_type_id => credit_card.id,    :status => true
ReceiptMetaType.create :name => "Master Card",   :tag_meta_type_id => credit_card.id,    :status => true
ReceiptMetaType.create :name => "Cash",   :tag_meta_type_id => cash.id,    :status => true

