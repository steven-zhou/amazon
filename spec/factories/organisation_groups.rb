Factory.define :organisation_group, :class => "OrganisationGroup" do |f|
  f.sequence(:organisation_id) { |n| n }
  f.sequence(:tag_id) { |n| n }
end