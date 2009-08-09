Factory.define :master_doc_meta_meta_type do |f|
  f.sequence(:id) { |n| n }
  f.sequence(:name) { |n| "name #{n}" }
end