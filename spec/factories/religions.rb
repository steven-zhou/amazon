Factory.define :religions do |f|
  f.sequence(:name) { |n| "religions_#{n}"}
end