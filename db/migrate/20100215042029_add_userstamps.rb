class AddUserstamps < ActiveRecord::Migration
  def self.up
    add_column :people, :creator, :integer
    add_column :people, :updater, :integer
    add_column :people, :deleter, :integer

    add_column :login_accounts, :creator, :integer
    add_column :login_accounts, :updater, :integer
    add_column :login_accounts, :deleter, :integer
  end

  def self.down
    remove_column :people, :creator, :integer
    remove_column :people, :updater, :integer
    remove_column :people, :deleter, :integer

    remove_column :login_accounts, :creator, :integer
    remove_column :login_accounts, :updater, :integer
    remove_column :login_accounts, :deleter, :integer
  end
end
