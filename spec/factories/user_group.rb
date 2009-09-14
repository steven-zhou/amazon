Factory.define :user_group, :class => UserGroup do |f|
  f.association :group, :factory => :group
  f.association :login_account, :factory => :login_account

end
