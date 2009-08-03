email = ContactMetaType.create :name => "Email"
phone = ContactMetaType.create :name => "Phone"
fax = ContactMetaType.create :name => "Fax"
website = ContactMetaType.create :name => "Website"

ContactType.create :name => "Email Work", :contact_meta_type_id => email.id
ContactType.create :name => "Email Personal", :contact_meta_type_id => email.id
ContactType.create :name => "Phone Mobile", :contact_meta_type_id => phone.id
ContactType.create :name => "Phone Home", :contact_meta_type_id => phone.id
ContactType.create :name => "Phone Business", :contact_meta_type_id => phone.id
ContactType.create :name => "Fax Home", :contact_meta_type_id => fax.id
ContactType.create :name => "Fax Business", :contact_meta_type_id => fax.id
ContactType.create :name => "Website Personal", :contact_meta_type_id => website.id
ContactType.create :name => "Website Business", :contact_meta_type_id => website.id




