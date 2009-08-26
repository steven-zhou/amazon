Factory.define :high_tech, :class => BusinessType do |f|
  f.sequence(:name) { |n| "High Technology #{n}" }
end