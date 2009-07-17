Factory.define :address_type do |f|
  f.name "Standard Address"
end

Factory.define :home_address_type, :parent => :address_type do |f|
  f.name "Home"
end

Factory.define :work_address_type, :parent => :address_type do |f|
  f.name "Work"
end