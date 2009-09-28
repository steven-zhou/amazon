class CreateDuplicationFormulaDetails < ActiveRecord::Migration
  def self.up
    create_table :duplication_formula_details do |t|
      t.integer :duplication_formula_id
      t.string :table_name
      t.string :field_name
      t.integer :number_of_charecter
      t.timestamps
    end
  end

  def self.down
    drop_table :duplication_formula_details
  end
end
