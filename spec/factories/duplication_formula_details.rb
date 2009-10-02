Factory.define :personal_duplication_formula_detail, :class => "DuplicationFormulaDetail" do |f|
  f.table_name "people"
  f.field_name "first_name"
  f.number_of_charecter 6

  f.association :duplication_formula, :factory => :personal_duplication_formula
end

Factory.define :organisational_duplication_formula_detail, :class => "DuplicationFormulaDetail" do |f|
  f.table_name "organisations"
  f.field_name "full_name"
  f.number_of_charecter 6

  f.association :duplication_formula, :factory => :organisational_duplication_formula
end
