Factory.define :website,:parent=>:contact,:class=>Website do |f|
  f.value  "foobar.com.au"
  f.remarks  "Remarkable"
  f.priority true

  f.association :contact_type
  f.association :contactable, :factory => :person
end