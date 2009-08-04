email = ContactMetaType.create :name => "Email"
phone = ContactMetaType.create :name => "Phone"
fax = ContactMetaType.create :name => "Fax"
website = ContactMetaType.create :name => "Website"

ContactType.create :name => "Work", :contact_meta_type_id => email.id
ContactType.create :name => "Personal", :contact_meta_type_id => email.id
ContactType.create :name => "Mobile", :contact_meta_type_id => phone.id
ContactType.create :name => "Home", :contact_meta_type_id => phone.id
ContactType.create :name => "Business", :contact_meta_type_id => phone.id
ContactType.create :name => "Home", :contact_meta_type_id => fax.id
ContactType.create :name => "Business", :contact_meta_type_id => fax.id
ContactType.create :name => "Personal", :contact_meta_type_id => website.id
ContactType.create :name => "Business", :contact_meta_type_id => website.id




