Factory.define :include_list, :class => "IncludeList" do |f|
  f.association :list_header, :factory => :list_header
  f.association :login_account, :factory => :login_account
end

Factory.define :exclude_list, :class => "ExcludeList" do |f|
  f.association :list_header, :factory => :list_header
  f.association :login_account, :factory => :login_account
end
