Factory.define :person do |f|
  f.first_name "first_name"
  f.middle_name "middle_name"
  f.family_name "family_name"
  f.maiden_name "maiden_name"
  f.preferred_name "first_name last_name"
  f.initials "FL"
  f.primary_salutation "Mr first_name last_name"

  #Association
  f.association :primary_title, :factory => :mr
  f.association :second_title, :factory => :dr
  f.association :gender, :factory => :male
  f.association :marital_status, :factory => :married

end

Factory.define :invalid_person, :class =>Person do |f|
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