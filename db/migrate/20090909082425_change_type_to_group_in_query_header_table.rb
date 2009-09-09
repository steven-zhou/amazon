class ChangeTypeToGroupInQueryHeaderTable < ActiveRecord::Migration
  def self.up
    remove_column :query_headers, :type
    add_column :query_headers, :group, :string
  end

  def self.down
    remove_column :query_headers, :group
    add_column :query_headers, :type, :string
  end
end
