Factory.define :group, :class => Group do |f|
  f.sequence(:name) { |n| "long_name_#{n}"}
  f.sequence(:description) { |n| "description_#{n}"}
  f.status true
  f.start_date Date.today
  f.end_date Date.today
  
  f.association :group_owner, :factory => :person
  f.association :group_type, :factory => :group_tag

end