class AddLoginAccountIdToListHeaders < ActiveRecord::Migration
  def self.up
    add_column :list_headers, :login_account_id, :integer
  end

  def self.down
    remove_column :list_headers, :login_account_id
  end
end
