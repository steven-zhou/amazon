class RenameTransactionsToDeposits < ActiveRecord::Migration
  def self.up
    rename_table :transaction_headers, :deposits
    rename_table :transaction_type_details, :deposit_details
    rename_table :transaction_allocations, :receipts
    rename_column :deposits, :transaction_date, :deposit_date
    remove_column :deposits, :receipt_meta_type_name
    remove_column :deposits, :receipt_type_name
    add_column :deposits, :extension, :boolean
    rename_column :deposit_details, :transaction_header_id, :deposit_id
    rename_column :receipts, :transaction_header_id, :deposit_id
  end

  def self.down
    rename_table :deposits, :transaction_headers
    rename_table :deposit_details, :transaction_type_details
    rename_table :receipts, :transaction_allocations
    rename_column :transaction_headers, :deposit_date, :transaction_date
    add_column :transaction_headers, :receipt_meta_type_name, :string
    add_column :transaction_headers, :receipt_type_name, :string
    remove_column :transaction_headers, :extension
    rename_column :transaction_type_details, :deposit_id, :transaction_header_id
    rename_column :transaction_allocations, :deposit_id, :transaction_header_id
  end
end
