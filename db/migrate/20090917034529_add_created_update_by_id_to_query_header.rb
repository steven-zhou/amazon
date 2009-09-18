class AddCreatedUpdateByIdToQueryHeader < ActiveRecord::Migration
  def self.up
    add_column :query_headers, :created_by_id, :integer
    add_column :query_headers, :updated_by_id, :integer
  end

  def self.down
    remove_column :query_headers, :created_by_id
    remove_column :query_headers, :updated_by_id
  end
end
