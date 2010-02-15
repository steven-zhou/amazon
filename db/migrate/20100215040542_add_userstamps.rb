class AddUserstampsPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :creator_id, :integer
    add_column :people, :updater_id, :integer
    add_column :people, :deleter_id, :integer

    add_column :login_accounts, :creator_id, :integer
    add_column :login_accounts, :updater_id, :integer
    add_column :login_accounts, :deleter_id, :integer
  end

  def self.down
    remove_column :people, :creator_id, :integer
    remove_column :people, :updater_id, :integer
    remove_column :people, :deleter_id, :integer

    remove_column :login_accounts, :creator_id, :integer
    remove_column :login_accounts, :updater_id, :integer
    remove_column :login_accounts, :deleter_id, :integer
  end
end
