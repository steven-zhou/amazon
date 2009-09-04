Factory.define :query_detail do |f|
  f.table_name "addresses"
  f.sequence "1"
  f.field_name "state"
  f.status true

  f.association :query_header, :factory => :query_header
end