Factory.define :mr, :class => Title do |f|
  f.sequence(:name) { |n| "Mr #{n}" }
end

Factory.define :mrs, :class => Title do |f|
  f.sequence(:name) { |n| "Mrs #{n}" }
end

Factory.define :dr, :class => Title do |f|
  f.sequence(:name) { |n| "Dr #{n}" }
end

Factory.define :prof, :class => Title do |f|
  f.sequence(:name) { |n| "Prof #{n}" }
end