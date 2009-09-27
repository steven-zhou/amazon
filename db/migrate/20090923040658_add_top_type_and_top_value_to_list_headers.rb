class AddTopTypeAndTopValueToListHeaders < ActiveRecord::Migration
  def self.up
    add_column :list_headers, :top_type, :string
    add_column :list_headers, :top_value, :integer
  end

  def self.down
    remove_column :list_headers, :top_type
    remove_column :list_headers, :top_value
  end
end
