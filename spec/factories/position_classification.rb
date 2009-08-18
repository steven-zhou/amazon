Factory.define :position_classification, :class => PositionClassification do |f|
  f.sequence(:name) { |n| "Management #{n}" }
end