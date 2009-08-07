Factory.define :email, :parent => :contact, :class => Email do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:priority_number) { |n| n }
  f.value  "foo@bar.com.au"
  f.remarks  "Remarkable"

  f.association :contactable, :factory => :john
  f.association :contact_type, :factory => :ct_email_work
end