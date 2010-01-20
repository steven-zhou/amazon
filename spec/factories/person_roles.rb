Factory.define :person_role, :class => "PersonRole" do |f|
  f.remarks "Some remark"
  f.assignment_date Date.today()
  f.start_date Date.today()
  f.end_date Date.today()

  f.association :role_assigner, :factory => :person
  f.association :role_player, :factory => :person
  f.association :role, :factory => :role
  
end