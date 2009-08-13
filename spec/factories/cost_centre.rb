Factory.define :cost_centre, :class => CostCentre do |f|
  f.sequence(:name) { |n| "Customer Service #{n}" }
end