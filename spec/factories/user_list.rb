Factory.define :user_list, :class => UserList do |f|
  
  f.association :list_header, :factory => :list_header
  f.association :login_account, :factory => :login_account

end
