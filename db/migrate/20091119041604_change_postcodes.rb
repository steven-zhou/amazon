class ChangePostcodes < ActiveRecord::Migration
  def self.up
    remove_column :postcodes, :geographical_area
    add_column :postcodes, :geo_area, :text
    remove_column :postcodes, :electoral_area
    add_column :postcodes, :elec_area, :text
    remove_column :postcodes, :country
    add_column :postcodes, :country_name, :text
  end

  def self.down
    add_column :postcodes, :geographical_area, :text
    remove_column :postcodes, :geo_area
    add_column :postcodes, :electoral_area, :text
    remove_column :postcodes, :elec_area
    add_column :postcodes, :country, :text
    remove_column :postcodes, :country_name
  end
end
