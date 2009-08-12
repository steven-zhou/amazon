Factory.define :relationship_type, :class => RelatiobnshipType do |f|
  f.sequence(:name) { |n| "Relationship Type #{n}" }
end