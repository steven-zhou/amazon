Factory.define :telecommunications, :class => IndustrySector do |f|
  f.sequence(:name) { |n| "Telecommunications #{n}" }
end