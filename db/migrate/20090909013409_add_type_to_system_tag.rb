class AddTypeToSystemTag < ActiveRecord::Migration
  def self.up
    add_column :tag_meta_types, :category, :string
    add_column :tag_types, :category, :string
    add_column :tags, :category, :string
  end

  def self.down
    remove_column :tag_meta_types, :type
    remove_column :tag_types, :type
    remove_column :tags, :type
  end
end
