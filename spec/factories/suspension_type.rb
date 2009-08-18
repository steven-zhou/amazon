Factory.define :suspension_type, :class => SuspensionType do |f|
  f.sequence(:name) { |n| "Pending case #{n}" }
end