Factory.define :doc_tag, :class => "MasterDocType" do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
end