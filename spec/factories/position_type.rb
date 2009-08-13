Factory.define :position_type, :class => PositionType do |f|
  f.sequence(:name) { |n| "Permanent #{n}" }
end