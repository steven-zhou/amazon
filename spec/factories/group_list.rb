Factory.define :group_list, :class => GroupList do |f|

  f.association :list_header, :factory => :list_header
  f.association :group_type, :factory => :group_type

end
