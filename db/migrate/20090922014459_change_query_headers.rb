class ChangeQueryHeaders < ActiveRecord::Migration
  def self.up
    add_column :query_headers, :top_value, :integer
    add_column :query_headers, :top_type, :string
    add_column :query_headers, :allow_duplication, :boolean
  end

  def self.down
    remove_column :query_headers, :top_value
    remove_column :query_headers, :top_type
    remove_column :query_headers, :allow_duplication
  end
end
