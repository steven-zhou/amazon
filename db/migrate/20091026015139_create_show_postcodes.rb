class CreateShowPostcodes < ActiveRecord::Migration
  def self.up
    create_table :show_postcodes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :show_postcodes
  end
end
