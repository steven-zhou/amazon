class AddOnlineStatusToLoginAccount < ActiveRecord::Migration
  def self.up
    add_column :login_accounts, :online_status, :boolean
  end

  def self.down
    remove_column :login_accounts, :online_status
  end
end
