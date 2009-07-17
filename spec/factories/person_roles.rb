Factory.define :person_roles do |f|
  f.association :john, :factory => :person
  f.association :role
  f.remarks "Some remark"
end