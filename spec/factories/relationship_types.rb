Factory.define :relationship_type, :class => RelationshipType do |f|
  f.sequence(:name) { |n| "Relationship Type #{n}" }
end