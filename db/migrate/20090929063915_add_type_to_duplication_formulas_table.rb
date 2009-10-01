class AddTypeToDuplicationFormulasTable < ActiveRecord::Migration
  def self.up
    add_column :duplication_formulas, :type, :string
  end

  def self.down
    remove_column :duplication_formulas, :type
  end
end
