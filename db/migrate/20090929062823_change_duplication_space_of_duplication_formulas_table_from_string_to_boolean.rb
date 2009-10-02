class ChangeDuplicationSpaceOfDuplicationFormulasTableFromStringToBoolean < ActiveRecord::Migration
  def self.up
    remove_column :duplication_formulas, :duplication_space
    add_column :duplication_formulas, :duplication_space, :boolean
  end

  def self.down
    remove_column :duplication_formulas, :duplication_space
    add_column :duplication_formulas, :duplication_space, :string
  end
end
