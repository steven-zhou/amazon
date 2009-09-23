Factory.define :doc_tag_type, :class => "MasterDocMetaType" do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
end

Factory.define :group_tag_type, :class => "GroupMetaType" do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
end