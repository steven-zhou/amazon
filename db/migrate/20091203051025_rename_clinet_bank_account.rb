class RenameClinetBankAccount < ActiveRecord::Migration
  def self.up
    rename_table :client_bank_accounts, :bank_accounts
  end

  def self.down
    rename_table  :bank_accounts,:client_bank_accounts

  end
end
