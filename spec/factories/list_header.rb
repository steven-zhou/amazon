Factory.define :list_header, :class => "StaticList" do |f|
  f.sequence(:name) { |n| "PeopleInNSW #{n}" }
  f.list_size "10"
  f.status true


  f.association :query_header, :factory => :query_header
end