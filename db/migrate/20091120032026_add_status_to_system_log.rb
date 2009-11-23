class AddStatusToSystemLog < ActiveRecord::Migration
  def self.up
    add_column :system_logs, :status, :text
  end

  def self.down
    remove_column :system_logs, :status
  end
end
