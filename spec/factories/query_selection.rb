Factory.define :query_selection, :class => QuerySelection do |f|
  f.table_name "addresses"
  f.field_name "state"
  f.status true

  f.association :query_header, :factory => :query_header
end