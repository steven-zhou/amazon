Factory.define :query_header do |f|
  f.sequence(:name) { |n| "PeopleInNSW #{n}" }
  f.description "People who live in NSW"
  f.status true
end