class RemoveColumnPostArea < ActiveRecord::Migration
  def self.up
     remove_column :post_areas , :country_name
  end

  def self.down
   add_column :post_areas , :country_name,:string
  end
end
