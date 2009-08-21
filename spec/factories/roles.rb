Factory.define :role, :class => Role do |f|
  f.sequence(:name) { |n| "Role_#{n}" }
  f.sequence(:description) { |n| "description_#{n}" }
  f.role_status true
  f.sequence(:remarks) { |n| "remarks_#{n}" }
  f.association :role_type, :factory => :role_type
end