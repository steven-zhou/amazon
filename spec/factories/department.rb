Factory.define :department, :class => Department do |f|
  f.sequence(:name) { |n| "S&D #{n}" }
end