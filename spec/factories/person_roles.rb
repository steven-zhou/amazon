Factory.define :person_roles do |f|
  f.remarks "Some remark"
  f.assignmen_date Date.today()
  f.start_date Date.today()
  f.end_date Date.today()

  f.association :role_player, :factory => :john
  f.association :role_assigner, :factory => :keivn
  f.association :role_approver, :factory => :steven
  f.association :role_superviser, :factory => :john
  f.association :role_manager, :factory => :john


  f.association :role, :factory => :yy
  
end