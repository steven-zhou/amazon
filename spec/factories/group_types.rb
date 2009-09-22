Factory.define :group_type do |f|
  f.sequence(:name) { |n| "name #{n}" }
 
end