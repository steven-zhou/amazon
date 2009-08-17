Factory.define :doc_tag_type, :class => "MasterDocMetaType" do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
end