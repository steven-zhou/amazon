Factory.define :query_criteria, :class => QueryCriteria do |f|
  f.option "And"
  f.table_name "Addresses"
  f.field_name "state"
  f.operator "equals"
  f.value "NSW"
  f.status true

  f.association :query_header, :factory => :query_header
end