Factory.define :email, :parent => :contact, :class => Email do |f|
  f.value  "foo@bar.com.au"
  f.remarks  "Remarkable"

  f.association :contact_type, :factory => :ct_email_work
  f.association :contactable, :factory => :john
end