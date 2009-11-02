class AddPasswordLifetimeToAccount < ActiveRecord::Migration
  def self.up
    add_column :login_accounts, :password_lifetime, :integer
    
  end

  def self.down
    remove_column :login_accounts, :password_lifetime
  end
end
