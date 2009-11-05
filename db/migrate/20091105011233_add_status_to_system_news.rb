class AddStatusToSystemNews < ActiveRecord::Migration
  def self.up
    add_column :system_news, :status, :boolean
  end

  def self.down
    remove_column :system_news, :status
  end
end
