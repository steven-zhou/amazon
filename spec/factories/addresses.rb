Factory.define :address do |f|
  f.building_name "Argyle"
  f.suite_unit "1"
  f.street_number "29"
  f.street_name "Arthur St"
  f.town "Argent"
  f.state "Aramethea"
  f.postal_code "1111"
  f.time_zone "+1"
  f.map_reference "A1"
  f.bar_code "1111"
  f.district "Archon"
  f.region "Arctic"
  f.association :country, :factory => :australia
  f.priority true
end

Factory.define :person_address, :parent => :address do |f|
  f.addressable_type "Person"
  f.association :addressable, :factory => :john
end

Factory.define :personal_home_address, :parent => :person_address do |f|
  f.association :address_type, :factory => :home_address_type
end

Factory.define :personal_work_address, :parent => :person_address do |f|
  f.association :address_type, :factory => :work_address_type
end

