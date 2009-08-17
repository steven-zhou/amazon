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