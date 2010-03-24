class RenameTransactionsToDeposits < ActiveRecord::Migration
  def self.up
    rename_table :transaction_headers, :deposits
    rename_table :transaction_allocations, :allocations
    rename_table :transaction_type_details, :deposit_details
    create_table :receipts, :force => true do |t|
      t.integer :deposit_id
      t.integer :entity_id
      t.string  :entity_type
      t.boolean :active
      t.integer :creator_id
      t.integer :updater_id
      t.timestamps
    end
    rename_column :deposits, :transaction_date, :deposit_date
    remove_column :deposits, :receipt_meta_type_name
    remove_column :deposits, :receipt_type_name
    add_column :deposits, :extension, :boolean
    rename_column :deposit_details, :transaction_header_id, :deposit_id
  end

  def self.down
    rename_table :deposits, :transaction_headers
    rename_table :allocations, :transaction_allocations
    rename_table :deposit_details, :transaction_type_details
    drop_table :receipts
    rename_column :transaction_headers, :deposit_date, :transaction_date
    add_column :transaction_headers, :receipt_meta_type_name, :string
    add_column :transaction_headers, :receipt_type_name, :string
    remove_column :transaction_headers, :extension
    rename_column :transaction_type_details, :deposit_id, :transaction_header_id
  end
end
