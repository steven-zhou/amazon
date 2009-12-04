class CreateTransactionAllocations < ActiveRecord::Migration
  def self.up
    create_table :transaction_allocations do |t|
      t.column :transaction_header_id, :integer
      t.column :receipt_account_id, :integer
      t.column :campaign_id, :integer
      t.column :source_id, :integer
      t.column :amount, :decimal, :precision => 11, :scale => 3
      t.column :letter_id, :integer
      t.column :letter_sent,:boolean
      t.column :date_sent, :date
      t.column :extention_id, :integer
      t.column :extention_type, :string
      t.column :cluster_id, :integer
      t.column :cluster_type, :string
      
      t.timestamps

    end
  end

  def self.down
    drop_table :transaction_allocations
  end
end
