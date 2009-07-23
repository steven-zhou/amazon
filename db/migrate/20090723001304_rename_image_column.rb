class RenameImageColumn < ActiveRecord::Migration
  def self.up
    rename_column :images, :image_file_name, :image_filename
    add_column :images, :created_at, :datetime
    add_column :images, :updated_at, :datetime
    remove_column :images, :image_updated_at
  end

  def self.down
    rename_column :images, :image_filename, :image_file_name
    remove_column :images, :created_at
    remove_column :images, :updated_at
    add_column :images, :image_updated_at, :datetime

  end
end
