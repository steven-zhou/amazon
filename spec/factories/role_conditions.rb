Factory.define :role_condition, :class => RoleCondition do |f|

  f.association :role, :factory => :role
  f.association :master_doc_type, :factory => :master_doc_type

end