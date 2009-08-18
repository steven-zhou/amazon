Factory.define :section, :class => Section do |f|
  f.sequence(:name) { |n| "Development #{n}" }
end