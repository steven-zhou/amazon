class AddStatusToDuplicationFormulas < ActiveRecord::Migration
  def self.up
    add_column :duplication_formulas, :status, :boolean
  end

  def self.down
    remove_column :duplication_formulas, :status
  end
end
