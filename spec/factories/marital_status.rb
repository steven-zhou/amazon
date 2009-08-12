Factory.define :marital_status, :class => MaritalStatus do |f|
  f.sequence(:name) { |n| "Marital Status #{n}" }
end

Factory.define :single, :class => MaritalStatus do |f|
  f.sequence(:name) { |n| "Single #{n}" }
end

Factory.define :married, :class => MaritalStatus do |f|
  f.sequence(:name) { |n| "Married #{n}" }
end

Factory.define :divorced, :class => MaritalStatus do |f|
  f.sequence(:name) { |n| "Divorced #{n}" }
end

Factory.define :engaged, :class => MaritalStatus do |f|
  f.sequence(:name) { |n| "Engaged #{n}" }
end
