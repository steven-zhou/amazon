class Renamebankaccountcolumn < ActiveRecord::Migration
  def self.up
    rename_column :bank_accounts, :entity_type,:type
  end

  def self.down
    rename_column :bank_accounts, :type, :entity_type
  end
end
