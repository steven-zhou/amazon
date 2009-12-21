class RemoveColumnCountries < ActiveRecord::Migration
  def self.up
    remove_column :countries , :govenment_language
  end

  def self.down
    add_column :countries , :govenment_language,:string
  end
end
