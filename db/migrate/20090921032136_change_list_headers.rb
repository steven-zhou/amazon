class ChangeListHeaders < ActiveRecord::Migration
  def self.up
    add_column :list_headers, :source, :string
    add_column :list_headers, :source_type, :string
    add_column :list_headers, :allow_duplication, :boolean
  end

  def self.down
    remove_column :list_headers, :source
    remove_column :list_headers, :source_type
    remove_column :list_headers, :allow_duplication
  end
end
