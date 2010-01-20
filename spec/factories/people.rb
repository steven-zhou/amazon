Factory.define :invalid_person, :class =>Person do |f|
end

Factory.define :person, :class => Person do |f|
  f.first_name "First_Name"
  f.middle_name "Middle_Name"
  f.family_name "Family_Name"
  f.maiden_name "Maiden_Name"
  f.preferred_name "Preferred_Name"
  f.initials "INITIALS"
  f.primary_salutation "Mr. John Doe"

  #Association
  f.association :primary_title, :factory => :title
  f.association :second_title, :factory => :title
  f.association :gender, :factory => :gender
  f.association :marital_status, :factory => :marital_status
end

Factory.define :john, :class => Person do |f|
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
