class ChangeReceiptMetaTypeToPaymentMethod < ActiveRecord::Migration
  def self.up
    rename_column :transaction_headers, :receipt_meta_type_id, :payment_method_type_id
    rename_column :transaction_headers, :receipt_type_id, :payment_method_id
  end

  def self.down
    rename_column :transaction_headers, :payment_method_type_id, :receipt_meta_type_id
    rename_column :transaction_headers, :payment_method_id, :receipt_type_id
  end
end
