Factory.define :user_group, :class => UserGroup do |f|
  
  f.association :group_type, :factory => :group_type
  f.association :login_account, :factory => :login_account

end
