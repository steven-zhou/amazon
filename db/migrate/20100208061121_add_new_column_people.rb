class AddNewColumnPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :status, :boolean
    add_column :people, :to_be_removed, :boolean
    add_column :organisations,  :status, :boolean
    add_column :organisations, :to_be_removed, :boolean
  end

  def self.down
   remove_column :people, :status
   remove_column :people, :to_be_removed
   remove_column :organisations,  :status
   remove_column :organisations, :to_be_removed
  end
end
