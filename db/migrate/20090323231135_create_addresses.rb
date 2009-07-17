class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :building_name
      t.string :suite_unit
      t.string :street_number
      t.string :street_name
      t.string :town
      t.string :state
      t.string :district
      t.string :region
      t.integer :country_id
      t.string :postal_code
      t.string :time_zone
      t.string :map_reference
      t.string :bar_code

      t.boolean :priority

      t.integer :address_type_id
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
