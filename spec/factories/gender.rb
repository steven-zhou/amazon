Factory.define :gender, :class => Gender do |f|
  f.sequence(:name) { |n| "Gender #{n}" }
end

Factory.define :male, :class => Gender do |f|
  f.sequence(:name) { |n| "Male #{n}" }
end

Factory.define :female, :class => Gender do |f|
  f.sequence(:name) { |n| "Female #{n}" }
end