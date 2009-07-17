Factory.define :email,:parent=>:contact,:class=>Email do |f|
  f.value  "foo@bar.com.au"
  f.remarks  "Remarkable"
  f.priority true

  f.association :contact_type
  f.association :contactable, :factory => :person
end