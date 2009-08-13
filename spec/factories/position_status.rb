Factory.define :position_status, :class => PositionStatus do |f|
  f.sequence(:name) { |n| "Full-time #{n}" }
end