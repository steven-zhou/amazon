Factory.define :role_type ,:class => RoleType do |f|
  f.sequence(:name) { |n| "Role #{n}" }
end