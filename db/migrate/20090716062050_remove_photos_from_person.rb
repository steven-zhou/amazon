class RemovePhotosFromPerson < ActiveRecord::Migration
  def self.up
    remove_column :people, :picture_path
    remove_column :people, :photo_file_name
    remove_column :people, :photo_content_type
    remove_column :people, :photo_updated_at
    remove_column :people, :photo_file_size


  end

  def self.down
    add_column :people, :picture_path, :string
    add_column :people, :photo_file_name, :string
    add_column :people, :photo_content_type, :string
    add_column :people, :photo_updated_at, :datetime
    add_column :people, :photo_file_size, :integer
  end
end
