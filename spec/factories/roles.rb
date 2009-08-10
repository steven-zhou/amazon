Factory.define :role, :class => "Role" do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "Role #{n}" }
  f.association :role_type, :factory => :role_type
end