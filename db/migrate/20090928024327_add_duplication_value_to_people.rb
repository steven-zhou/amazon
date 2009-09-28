class AddDuplicationValueToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :duplication_value, :string
  end

  def self.down
    remove_column :people, :duplication_value
  end
end
