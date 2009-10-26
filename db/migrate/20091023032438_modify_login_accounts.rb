class ModifyLoginAccounts < ActiveRecord::Migration
  def self.up
    add_column :login_accounts, :access_attempt_ip, :text
    add_column :login_accounts, :access_attempts_count, :integer
  end

  def self.down
    remove_column :login_accounts, :access_attempt_ip
    remove_column :login_accounts, :access_attempts_count
  end
end
