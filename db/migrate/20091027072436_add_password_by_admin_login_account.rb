class AddPasswordByAdminLoginAccount < ActiveRecord::Migration
  def self.up
    add_column :login_accounts, :password_by_admin, :boolean
  
  end

  def self.down
    remove_column :login_accounts, :password_by_admin
  
  end
end
