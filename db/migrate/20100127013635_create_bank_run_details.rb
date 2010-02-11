class CreateBankRunDetails < ActiveRecord::Migration
  def self.up
    create_table :bank_run_details, :force => true do |t|
      t.integer :bank_run_id
      t.integer :transaction_header_id
      t.timestamps
    end
  end

  def self.down
    drop_table :bank_run_details
  end
end
