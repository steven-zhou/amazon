Factory.define :ct_email_work, :class => ContactType do |f|
  f.name "Work"
  f.association :contact_meta_type, :factory => :cmt_email
end

Factory.define :ct_email_home, :class => ContactType do |f|
  f.name "Home"
  f.association :contact_meta_type, :factory => :cmt_email
end

Factory.define :ct_phone_business, :class => ContactType do |f|
  f.name "Business"
  f.association :contact_meta_type, :factory => :cmt_phone
end


Factory.define :ct_phone_home, :class => ContactType do |f|
  f.name "Home"
  f.association :contact_meta_type, :factory => :cmt_phone
end


Factory.define :ct_fax_work, :class => ContactType do |f|
  f.name "Work"
  f.association :contact_meta_type, :factory => :cmt_fax
end


Factory.define :ct_website_work, :class => ContactType do |f|
  f.name "Work"
  f.association :contact_meta_type, :factory => :cmt_website
end


