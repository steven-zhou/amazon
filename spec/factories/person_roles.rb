Factory.define :person_role, :class => "PersonRole" do |f|
  f.remarks "Some remark"
  f.assignment_date Date.today()
  f.start_date Date.today()
  f.end_date Date.today()


  f.association :role_assigner, :factory => :person

  f.association :role_player, :factory => :person
  f.association :role, :factory => :role
  f.association :assigned_by, :factory => :john
  f.association :role_approver, :factory => :john
  f.association :role_superviser, :factory => :john
  f.association :role_manager, :factory => :john
  f.association :role_assigner, :factory => :john


end