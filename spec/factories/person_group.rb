Factory.define :person_group, :class => "PersonGroup" do |f|
  f.sequence(:people_id) { |n| n }
  f.sequence(:tag_id) { |n| n }
end