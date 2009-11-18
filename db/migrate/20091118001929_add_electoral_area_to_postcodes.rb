class AddElectoralAreaToPostcodes < ActiveRecord::Migration
  def self.up
    add_column :postcodes, :geographical_area, :text
    add_column :postcodes, :electoral_area_id, :integer
    remove_column :postcodes, :county
    add_column :postcodes, :country, :text
  end

  def self.down
    remove_column :postcodes, :geographical_area
    remove_column :postcodes, :electoral_area_id
    add_column :postcodes, :county, :text
    remove_column :postcodes, :country, :text
  end
end
