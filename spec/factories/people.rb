Factory.define :invalid_person, :class =>Person do |f|
end

Factory.define :john, :class => Person do |f|
  f.sequence(:id) { |n| n }
  f.first_name "John"
  f.middle_name "Buck"
  f.family_name "Doe"
  f.maiden_name ""
  f.preferred_name "Deer"
  f.initials "JD"
  f.primary_salutation "Mr. John Doe"

  #Association
  f.association :primary_title, :factory => :mr
  f.association :second_title, :factory => :prof
  f.association :gender, :factory => :male
  f.association :marital_status, :factory => :single
end

Factory.define :jane, :class => Person do |f|
  f.sequence(:id) { |n| n }
  f.first_name "Jane"
  f.middle_name "Rose"
  f.family_name "Doe"
  f.maiden_name "Dorris"
  f.preferred_name "Janey"
  f.initials "JD"
  f.primary_salutation "Mrs Jane Doe"

  #Association
  f.association :primary_title, :factory => :mrs
  f.association :gender, :factory => :female
  f.association :marital_status, :factory => :divorced
end