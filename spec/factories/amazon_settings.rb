Factory.define :male_gender, :class => "Gender" do |f|
  f.name "Male"
  f.created_at Date.today()
  f.updated_at Date.today()
  f.description "gender"
  f.status true
end

Factory.define :female_gender, :class => "Gender" do |f|
  f.name "Female"
  f.created_at Date.today()
  f.updated_at Date.today()
  f.description "gender"
  f.status true
end

Factory.define :male_title, :class => "Title" do |f|
  f.name "Male"
  f.created_at Date.today()
  f.updated_at Date.today()
  f.description "title"
  f.status true
end

Factory.define :security_question1, :class => "SecurityQuestion" do |f|
  f.sequence(:name) { |n| "What is your name?#{n}" }
  f.sequence(:description) { |n| "name#{n}" }
  f.status true
end

Factory.define :security_question2, :class => "SecurityQuestion" do |f|
  f.sequence(:name) { |n| "What is your pet?#{n}" }
  f.sequence(:description) { |n| "pet#{n}" }
  f.status true
end

Factory.define :security_question3, :class => "SecurityQuestion" do |f|
  f.sequence(:name) { |n| "What is your emial?#{n}" }
  f.sequence(:description) { |n| "email#{n}" }
  f.status true
end