Factory.define :doc_tag, :class => "MasterDocType" do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
  f.association :tag_type, :factory => :doc_tag_type
end

Factory.define :group_type, :class => "GroupType" do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
#  f.sequence(:to_be_removed) { |n| false  }
end


