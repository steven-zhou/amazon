Factory.define :role_type do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "Role #{n}" }
end