class ChangePasswardLifetimeToPasswordLifetime < ActiveRecord::Migration
  def self.up
    remove_column :client_setups, :passward_lifetime
    add_column :client_setups, :password_lifetime, :integer
  end

  def self.down
    remove_column :client_setups, :password_lifetime
    add_column :client_setups, :passward_lifetime, :integer
  end
end
