class CreateShowPostcodeGrids < ActiveRecord::Migration
  def self.up
    create_table :show_postcode_grids do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :show_postcode_grids
  end
end
