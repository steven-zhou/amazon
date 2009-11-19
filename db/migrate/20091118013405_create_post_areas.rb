class CreatePostAreas < ActiveRecord::Migration
  def self.up
    create_table :post_areas do |t|
      t.integer "country_id"
      t.string "country"
      t.string "division_name"
      t.string "remarks"
      t.string "type"
      t.timestamps

    end
  end

  def self.down
    drop_table :post_areas
  end
end
