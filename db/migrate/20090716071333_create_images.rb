class CreateImages < ActiveRecord::Migration
  def self.up

    create_table :images do |t|
      t.column :image_file_data, :binary
      t.column :image_file_name, :string
      t.column :image_width, :integer
      t.column :image_height, :integer
      t.column :image_updated_at, :datetime

      t.references :imageable, :polymorphic => true

    end
  end

  def self.down
    drop_table :images
  end
end
