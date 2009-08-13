Factory.define :position_title, :class => PositionTitle do |f|
  f.sequence(:name) { |n| "Developer #{n}" }
end