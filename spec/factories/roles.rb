Factory.define :super_role, :class => "Role" do |f|
  f.name "super"
  f.association :role_type
end