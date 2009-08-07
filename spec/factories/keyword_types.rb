Factory.define :keyword_type do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
end