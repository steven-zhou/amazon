class CreateTransactionHeaders < ActiveRecord::Migration
  def self.up
    create_table :transaction_headers do |t|
      t.column :entity_id, :integer
      t.column :entity_type, :string
      t.column :todays_date, :date
      t.column :transaction_date, :date
      t.column :receipt_meta_type_id, :integer
      t.column :receipt_type_id, :integer
      t.column :bank_account_id, :integer
      t.column :bank_run_id, :integer
      t.column :receipt_number, :integer
      t.column :letter_id, :integer
      t.column :letter_sent,:boolean
      t.column :date_sent, :date
      t.column :total_amount, :decimal, :precision => 11, :scale => 3
      t.column :notes, :text
      t.column :received_via_id, :integer
      t.column :banked, :boolean
      t.timestamps

    end
  end

  def self.down
    drop_table :transaction_headers
  end
end
