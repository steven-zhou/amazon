class RemoveListableTypeFromListDetails < ActiveRecord::Migration
  def self.up
    remove_column :list_details, :listable_type
  end

  def self.down
    add_column :list_details, :listable_type, :string
  end
end
