class ModifyLoginAccount < ActiveRecord::Migration
  def self.up
    add_column :login_accounts, :password_updated_at, :timestamp
    add_column :login_accounts, :created_at, :timestamp
    add_column :login_accounts, :updated_at, :timestamp
  end

  def self.down
    remove_column :login_accounts, :password_updated_at
    remove_column :login_accounts, :created_at
    remove_column :login_accounts, :updated_at
  end
end
