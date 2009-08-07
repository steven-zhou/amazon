Factory.define :master_doc_type do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
  f.association :master_doc_meta_type, :factory => :master_doc_meta_type
end