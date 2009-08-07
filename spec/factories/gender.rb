Factory.define :male, :class => Gender do |f|
  f.sequence(:name) { |n| "Male #{n}" }
end

Factory.define :female, :class => Gender do |f|
  f.sequence(:name) { |n| "Female #{n}" }
end