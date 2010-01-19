Factory.define :doc_tag_type, :class => "MasterDocMetaType" do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
    f.association :tag_meta_type, :factory => :doc_tag_meta_type
end

Factory.define :group_tag_type, :class => "GroupMetaType" do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
end