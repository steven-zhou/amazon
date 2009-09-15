Factory.define :query_sorter do |f|
  f.table_name "addresses"
  f.field_name "state"
  f.ascending true
  f.status true

  f.association :query_header, :factory => :query_header
end