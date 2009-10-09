class RemoveQueryHeaderIdFromListHeadersTable < ActiveRecord::Migration
  def self.up
    remove_column :list_headers, :query_header_id
  end

  def self.down
    add_column :list_headers, :query_header_id, :integer
  end
end
