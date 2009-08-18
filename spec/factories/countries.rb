Factory.define :australia, :class => Country do |f|
  f.long_name "Australia"
  f.short_name "Australia"
  f.citizenship "Australian"
  f.capital "Canberra"
  f.iso_code "AU"
  f.currency "dollar"
  f.currency_subunit "cents"
  f.association :main_language, :factory => :language 
end