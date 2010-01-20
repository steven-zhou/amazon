
Factory.define :query_header, :class => "PersonQueryHeader" do |f|

  f.sequence(:name) { |n| "PeopleInNSW #{n}" }
  f.description "People who live in NSW"
  f.status true
end

Factory.define :org_query_header, :class => "OrganisationQueryHeader" do |f|
  f.sequence(:name) { |n| "OrgInNSW #{n}" }
  f.description "Org who live in NSW"
  f.status true
end