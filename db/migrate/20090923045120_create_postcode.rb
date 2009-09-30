class CreatePostcode < ActiveRecord::Migration
  def self.up
    create_table :postcodes do |t|
      t.column :country_id, :integer
      t.column :type, :text
      t.column :governance, :text
      t.column :province, :text
      t.column :state, :text
      t.column :county, :text
      t.column :region, :text
      t.column :district, :text
      t.column :zone, :text
      t.column :city, :text
      t.column :town, :text
      t.column :suburb, :text
      t.column :electoral_area, :text
      t.column :postcode, :text
      t.column :mail_code, :text
      t.column :bulk_code, :text
      t.column :geographical_area_id, :integer
    end


  end

  def self.down
    drop_table :postcodes
  end
end
