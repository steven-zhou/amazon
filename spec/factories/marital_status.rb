Factory.define :single, :class => MaritalStatus do |f|
  f.name "Single"
end

Factory.define :married, :class => MaritalStatus do |f|
  f.name "Married"
end

Factory.define :divorced, :class => MaritalStatus do |f|
  f.name "Divorced"
end

Factory.define :engaged, :class => MaritalStatus do |f|
  f.name "Engaged"
end
