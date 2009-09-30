Factory.define :duplication_formula_details do |f|
  f.table_name "people"
  f.field_name "first_name"
  f.number_of_charecter 6

  f.association :duplication_formula, :factory => :duplication_formula
end
