Factory.define :query_criteria do |f|
  f.sequence "1"
  f.option ""
  f.table_name "addresses"
  f.field_name "state"
  f.operator "="
  f.value "NSW"
  f.status true

  f.association :query_header, :factory => :query_header
end