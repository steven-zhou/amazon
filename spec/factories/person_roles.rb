Factory.define :person_role, :class => "PersonRole" do |f|
  f.remarks "Some remark"
  f.assignment_date Date.today()
  f.start_date Date.today()
  f.end_date Date.today()

  f.association :role_player, :factory => :john
  f.association :role_assigner, :factory => :john
  f.association :role_approver, :factory => :john
  f.association :role_superviser, :factory => :john
  f.association :role_manager, :factory => :john


  f.association :role, :factory => :role
  
end