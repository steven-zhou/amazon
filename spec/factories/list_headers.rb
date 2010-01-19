Factory.define :list_header, :class => PersonListHeader do |f|
  f.sequence(:name) { |n| "PeopleInNSW List #{n}" }
  f.list_size "1"
  f.status true

end

Factory.define :primary_list do |f|
  f.sequence(:name) {|n| "Primary List #{n}"}
  f.list_size "0"
  f.status true
end
