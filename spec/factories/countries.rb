Factory.define :australia, :class => Country do |f|
  f.sequence(:long_name) { |n| "Australian#{n}" }
  f.sequence(:short_name) { |n| "Australian#{n}" }
  f.sequence(:citizenship) { |n| "Australian#{n}" }
  f.capital "Canberra"
  f.iso_code "AU"
  f.currency "dollar"
  f.currency_subunit "cents"
  f.association :main_language, :factory => :language 
end