class RemoveColumnsPostcode < ActiveRecord::Migration
 def self.up
    remove_column :postcodes , :geo_area
    remove_column :postcodes , :elec_area
  end

  def self.down
    add_column :postcodes , :geo_area,:string
    add_column :postcodes , :elec_area,:string
  end
end
