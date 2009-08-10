Factory.define :fax, :parent => :contact, :class => Fax do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:priority_number) { |n| n }
  f.pre_value  "02"
  f.value  "9876 1111"
  f.post_value  "ext 4356"
  f.preferred_time  "After 6"
  f.preferred_day  "Mon-Fri"
  f.remarks  "Remarkable"
  f.association :contact_type, :factory => :ct_fax_work
  f.association :contactable, :factory => :john
end