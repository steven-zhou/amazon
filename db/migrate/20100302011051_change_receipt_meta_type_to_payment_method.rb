class ChangeReceiptMetaTypeToPaymentMethod < ActiveRecord::Migration
  def self.up
    rename_column :employments, :payment_method_id, :payroll_method_id
    rename_column :transaction_headers, :receipt_meta_type_id, :payment_method_meta_type_id
    rename_column :transaction_headers, :receipt_type_id, :payment_method_type_id
    rename_column :membership_fees, :payment_method_id, :payment_method_type_id
  end

  def self.down
    rename_column :employments, :payroll_method_id, :payment_method_id
   rename_column :transaction_headers, :payment_method_meta_type_id, :receipt_meta_type_id
    rename_column :transaction_headers, :payment_method_type_id, :receipt_type_id
    rename_column :membership_fees, :payment_method_type_id, :payment_method_id
  end
end
