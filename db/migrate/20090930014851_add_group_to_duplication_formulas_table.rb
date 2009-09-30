class AddGroupToDuplicationFormulasTable < ActiveRecord::Migration
  def self.up
    add_column :duplication_formulas, :group, :string
  end

  def self.down
    remove_column :duplication_formulas, :group
  end
end
