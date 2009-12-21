class RemovePostcodeColumn < ActiveRecord::Migration
  def self.up
    remove_column :postcodes , :country_name
  end

  def self.down
    add_column :postcodes , :country_name,:string
  end
end
