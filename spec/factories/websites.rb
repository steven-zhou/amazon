Factory.define :website, :parent => :contact, :class => Website do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:priority_number) { |n| n }
  f.value  "www.foobar.com.au"
  f.remarks  "Remark"
  f.association :contact_type, :factory => :ct_website_work
  f.association :contactable, :factory => :john
end