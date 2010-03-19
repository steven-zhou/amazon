class AddManualReceiptNumberToTransactionHeaders < ActiveRecord::Migration
  def self.up
    add_column :transaction_headers, :manual_receipt_number, :string
  end

  def self.down
    remove_column :transaction_headers, :manual_receipt_number
  end
end
