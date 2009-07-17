Factory.define :title do |f|
  f.sequence(:name) { |n| "title_#{n}"}
  f.association :title_type
end