class ChangePostArea < ActiveRecord::Migration
  def self.up
    
    remove_column :post_areas, :country

    add_column :post_areas, :country_name, :string
  end

  def self.down

    add_column :post_areas, :country, :string

    remove_column :post_areas, :country_name
  end
end
