class AddNewColumnToReceiptAccountTable < ActiveRecord::Migration
  def self.up
        add_column :receipt_accounts, :receipt_account_type_id, :integer
  end

  def self.down
    remove_column :receipt_accounts, :receipt_account_type_id
  end
end
