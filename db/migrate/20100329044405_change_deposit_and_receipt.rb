class ChangeDepositAndReceipt < ActiveRecord::Migration
  def self.up
    remove_column :deposits, :receipt_number
    remove_column :deposits, :manual_receipt_number
    remove_column :deposits, :extension

    add_column :receipts, :receipt_number, :integer
    add_column :receipts, :manual_receipt_number, :integer
    add_column :receipts, :type, :string
    add_column :receipts, :entity_receipt_id, :integer

    remove_column :receipts, :extention_type
    remove_column :receipts, :extention_id
    remove_column :receipts, :cluster_type
    remove_column :receipts, :cluster_id

  end

  def self.down
    add_column :deposits, :receipt_number, :integer
    add_column :deposits, :manual_receipt_number, :string
    add_column :deposits, :extension, :boolean

    remove_column :receipts, :receipt_number
    remove_column :receipts, :manual_receipt_number
    remove_column :receipts, :type
    remove_column :receipts, :entity_receipt_id
    
    add_column :receipts, :extention_type, :string
    add_column :receipts, :extention_id, :integer
    add_column :receipts, :cluster_type, :string
    add_column :receipts, :cluster_id, :integer




  end
end
