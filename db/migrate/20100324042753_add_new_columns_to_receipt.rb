class AddNewColumnsToReceipt < ActiveRecord::Migration
  def self.up
    add_column :receipts, :entity_id, :integer
    add_column :receipts, :entity_type, :string
  end

  def self.down
    remove_column :receipts, :entity_id, :integer
    remove_column :receipts, :entity_type, :string
  end
end
