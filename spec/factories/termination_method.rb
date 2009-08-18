Factory.define :termination_method, :class => TerminationMethod do |f|
  f.sequence(:name) { |n| "By notice #{n}" }
end