class AddIsForeignKeyDuplicationFormulaDetailsTable < ActiveRecord::Migration
  def self.up
    add_column :duplication_formula_details, :is_foreign_key, :boolean
  end

  def self.down
    remove_column :duplication_formula_details, :is_foreign_key
  end
end
