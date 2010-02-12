class CreateBankRunReportDetails < ActiveRecord::Migration
  def self.up
    create_table :bank_run_report_details, :force => true do |t|
      t.integer :bank_run_report_id
      t.column :type, :string
      t.column :drawer_name, :string
      t.column :cheque_no, :string
      t.integer :bank_id
      t.column :total_amount, :decimal, :precision => 11, :scale => 3
      t.column :payment_type, :string
      t.column :receipt_no, :string
      t.column :card_type, :string
      t.integer :merchant_number
      t.column :merchant_trading_name, :string
      t.integer :no_of_item
      t.column :location, :string
      t.column :authority_no, :string
      t.column :cardholder_name, :string
      t.column :payment_via, :string
      t.integer :item
      t.column :card_number, :decimal
      t.integer :cvv
      t.column :account_code, :string
      t.column :cash, :decimal ,:precision => 11, :scale => 3
      t.column :cheque, :decimal, :precision => 11, :scale => 3
      t.column :cards, :decimal, :precision => 11, :scale => 3
      t.column :type_of_receipt, :string
      t.integer :campaign_id
      t.timestamps
    end
  end

  def self.down
    drop_table :bank_run_report_details
  end
end
