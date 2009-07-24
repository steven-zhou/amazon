Factory.define :google, :class => Organisation do |f|
  f.custom_id "GOGL"
  f.full_name "Google Enterprises"
  f.short_name "Google"
  f.trading_as "The Google"
  f.registered_name "Google Company Ltd"
  f.registered_number "56843545421212"
  f.registered_date Date.today()
  f.organisation_type "IT/Communication"
  f.tax_file_no "54787423435455"
  f.legal_no_1 ""
  f.legal_no_2 ""
  f.business_classification "Empire Building"
  f.business_nature "Technology"
  f.business_category "Search Engine"
  f.business_sub_category "Marketing"
  f.industrial_sector "Telecommunications"
  f.industrial_code ""
  f.number_of_full_time_employees 5000
  f.number_of_part_time_employees 1
  f.number_of_contractors 2
  f.number_of_volunteers 3
  f.number_of_other_workers 4
  f.business_mission "To take out Microsoft"
  f.remarks "We know everything about you"
  f.association :country, :factory => :australia
  f.association :organisation_hierarchy, :factory => :global_head

end