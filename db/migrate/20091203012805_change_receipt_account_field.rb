class ChangeReceiptAccountField < ActiveRecord::Migration
  def self.up
     
    add_column :receipt_accounts, :link_module_id, :integer
    add_column :receipt_accounts, :link_module_name, :text
    remove_column :receipt_accounts, :receipt_account_type_id
  end

  def self.down
    remove_column :receipt_accounts, :link_module_id
    remove_column :receipt_accounts, :link_module_name
    add_column :receipt_accounts,  :receipt_account_type_id, :integer
  end
end
