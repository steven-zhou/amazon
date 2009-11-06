pdf = PersonalDuplicationFormula.create :duplication_space => true, :description => "Default Setting : Primary Title(6) + First Name(10) + Family Name(10)", :group => "default"
DuplicationFormulaDetail.create :duplication_formula_id => pdf.id, :table_name => "people", :field_name => "primary_title", :number_of_charecter => 6, :is_foreign_key => true
DuplicationFormulaDetail.create :duplication_formula_id => pdf.id, :table_name => "people", :field_name => "first_name", :number_of_charecter => 10, :is_foreign_key => false
DuplicationFormulaDetail.create :duplication_formula_id => pdf.id, :table_name => "people", :field_name => "family_name", :number_of_charecter => 10, :is_foreign_key => false
odf = OrganisationalDuplicationFormula.create :duplication_space => true, :description => "Default Setting : Full Name(10) + Trade As(10) + Registered Name(10)", :group => "default"
DuplicationFormulaDetail.create :duplication_formula_id => odf.id, :table_name => "organisations", :field_name => "full_name", :number_of_charecter => 10, :is_foreign_key => false
DuplicationFormulaDetail.create :duplication_formula_id => odf.id, :table_name => "organisations", :field_name => "trading_as", :number_of_charecter => 10, :is_foreign_key => false
DuplicationFormulaDetail.create :duplication_formula_id => odf.id, :table_name => "organisations", :field_name => "registered_name", :number_of_charecter => 10, :is_foreign_key => false
pdf = PersonalDuplicationFormula.create :duplication_space => true, :description => "Default Setting : Primary Title(6) + First Name(10) + Family Name(10)", :group => "applied"
DuplicationFormulaDetail.create :duplication_formula_id => pdf.id, :table_name => "people", :field_name => "primary_title", :number_of_charecter => 6, :is_foreign_key => true
DuplicationFormulaDetail.create :duplication_formula_id => pdf.id, :table_name => "people", :field_name => "first_name", :number_of_charecter => 10, :is_foreign_key => false
DuplicationFormulaDetail.create :duplication_formula_id => pdf.id, :table_name => "people", :field_name => "family_name", :number_of_charecter => 10, :is_foreign_key => false
odf = OrganisationalDuplicationFormula.create :duplication_space => true, :description => "Default Setting : Full Name(10) + Trade As(10) + Registered Name(10)", :group => "applied"
DuplicationFormulaDetail.create :duplication_formula_id => odf.id, :table_name => "organisations", :field_name => "full_name", :number_of_charecter => 10, :is_foreign_key => false
DuplicationFormulaDetail.create :duplication_formula_id => odf.id, :table_name => "organisations", :field_name => "trading_as", :number_of_charecter => 10, :is_foreign_key => false
DuplicationFormulaDetail.create :duplication_formula_id => odf.id, :table_name => "organisations", :field_name => "registered_name", :number_of_charecter => 10, :is_foreign_key => false

