Factory.define :query_detail do |f|
  f.connector ""
  f.table_name "addresses"
  f.field_name "state"
  f.operator "="
  f.value "NSW"

  f.association :query_header, :factory => :query_header
end