Factory.define :google, :class => Organisation do |f|
  f.sequence(:id) { |n| n }
  f.custom_id "GOGL"
  f.full_name "Google Enterprises"
  f.short_name "Google"
  f.trading_as "The Google"
  f.registered_name "Google Company Ltd"
  f.registered_number "56843545421212"
  f.registered_date Date.today()  
  f.tax_file_no "54787423435455"
  f.legal_no_1 ""
  f.legal_no_2 ""  
  f.number_of_full_time_employees 5000
  f.number_of_part_time_employees 1
  f.number_of_contractors 2
  f.number_of_volunteers 3
  f.number_of_other_workers 4
  f.business_mission "To take out Microsoft"
  f.remarks "We know everything about you"
  f.association :country, :factory => :australia
  f.association :organisation_hierarchy, :factory => :global_head
  f.association :organisation_type, :factory => :it
  f.association :business_type, :factory => :high_tech
  f.association :business_category, :factory => :search_engine
  f.association :industry_sector, :factory => :telecommunications
end

Factory.define :invalid_organisation, :class =>Organisation do |f|
end