class AddTypeToLoginAccounts < ActiveRecord::Migration
  def self.up
    add_column :login_accounts, :type, :string
  end

  def self.down
    remove_column :login_accounts, :type
  end
end
