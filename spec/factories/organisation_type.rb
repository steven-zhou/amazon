Factory.define :it, :class => OrganisationType do |f|
  f.sequence(:name) { |n| "IT/Communication #{n}" }
end