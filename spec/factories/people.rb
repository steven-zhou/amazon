Factory.define :person do |f|
  f.sequence(:custom_id) { |n| "custom_id_#{n}"}
  f.sequence(:first_name) { |n| "foo_#{n}"}
  f.sequence(:middle_name) { |n| "mid_#{n}"}
  f.sequence(:family_name) { |n| "baz_#{n}"}
  f.maiden_name "value for maiden_name"
  f.sequence(:preferred_name) { |n| "bar_#{n}"}
  f.initials "value for initials"
  f.post_title  "value for post_title"
  f.gender  "value for gender"
  f.marital_status "value for marital_status"
  f.birth_date Date.today
  f.primary_salutation "Mr. Foo Bar"
  f.second_salutation "Foo Bar"

  #Association
  f.association :title, :factory => :title
  f.association :second_title, :factory => :title
end

Factory.define :invalid_person, :class =>Person do |f|
end

Factory.define :john, :class => Person do |f|
  f.first_name "John"
  f.middle_name "Buck"
  f.family_name "Doe"
  f.maiden_name "value for maiden_name"
  f.preferred_name "Deer"
  f.initials "JD"
  f.gender "Male"
  f.marital_status "Single"
  f.primary_salutation "Mr. John Doe"

  #Association
  f.association :title, :factory => :title
  f.association :second_title, :factory => :title
end