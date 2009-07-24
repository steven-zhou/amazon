Factory.define :google_ceo, :class => OrganisationKeyPersonnel do |f|
  f.designation "CEO"
  f.remarks "Very important person"
  f.association :organisation, :factory => :google
  f.association :person, :factory => :john
end