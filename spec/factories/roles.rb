Factory.define :role, :class => Role do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "Role_#{n}" }
  f.sequence(:description) { |n| "description_#{n}" }
  f.sequence(:remarks) { |n| "remarks_#{n}" }

  f.association :role_type, :factory => :role_type
   f.association :role_condition, :factory => :role_condition
end