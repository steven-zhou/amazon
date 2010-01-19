Factory.define :australia, :class => Country do |f|
  f.sequence(:short_name) { |n| "Australia #{n}" }
   f.sequence(:citizenship) { |n| "Australian #{n}" }
end