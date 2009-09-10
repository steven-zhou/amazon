class AddAscendingToQueryDetails < ActiveRecord::Migration
  def self.up
    add_column :query_details, :ascending, :boolean
  end

  def self.down
    remove_column :query_details, :ascending
  end
end
