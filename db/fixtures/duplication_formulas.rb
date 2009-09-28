df = DuplicationFormula.create :duplication_space => "Primary List", :description => "Default Setting : Primary Title(6) + First Name(10) + Family Name(10)"
DuplicationFormulaDetail.create :duplication_formula_id => df.id, :table_name => "people", :field_name => "primary_title", :number_of_charecter => 6
DuplicationFormulaDetail.create :duplication_formula_id => df.id, :table_name => "people", :field_name => "first_name", :number_of_charecter => 10
DuplicationFormulaDetail.create :duplication_formula_id => df.id, :table_name => "people", :field_name => "family_name", :number_of_charecter => 10