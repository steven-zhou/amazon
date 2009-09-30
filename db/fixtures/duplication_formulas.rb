pdf = PersonalDuplicationFormula.create :duplication_space => true, :description => "Default Setting : Primary Title(6) + First Name(10) + Family Name(10)", :group => "default"
DuplicationFormulaDetail.create :duplication_formula_id => pdf.id, :table_name => "people", :field_name => "primary_title", :number_of_charecter => 6
DuplicationFormulaDetail.create :duplication_formula_id => pdf.id, :table_name => "people", :field_name => "first_name", :number_of_charecter => 10
DuplicationFormulaDetail.create :duplication_formula_id => pdf.id, :table_name => "people", :field_name => "family_name", :number_of_charecter => 10
odf = OrganisationalDuplicationFormula.create :duplication_space => true, :description => "Default Setting : Full Name(10) + Trade As(10) + Registered Name(10)", :group => "default"
DuplicationFormulaDetail.create :duplication_formula_id => odf.id, :table_name => "organisation", :field_name => "full_name", :number_of_charecter => 10
DuplicationFormulaDetail.create :duplication_formula_id => odf.id, :table_name => "organisation", :field_name => "trade_as", :number_of_charecter => 10
DuplicationFormulaDetail.create :duplication_formula_id => odf.id, :table_name => "organisation", :field_name => "registered_name", :number_of_charecter => 10
