class ChangeClientBankAccount < ActiveRecord::Migration
 def self.up
    add_column :client_bank_accounts, :entity_id, :integer
    add_column :client_bank_accounts, :entity_type, :text
    add_column :client_bank_accounts, :account_type_id,:integer
    add_column :client_bank_accounts, :priority_number,:integer
  end

  def self.down
    remove_column :client_bank_accounts, :entity_id
    remove_column :client_bank_accounts, :entity_type
    remove_column :client_bank_accounts, :account_type_id
    remove_column :client_bank_accounts, :priority_number
  end
end
