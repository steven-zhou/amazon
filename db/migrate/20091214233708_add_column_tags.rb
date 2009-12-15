class AddColumnTags < ActiveRecord::Migration
   def self.up
    add_column :tags, :to_be_removed ,:boolean
  end

  def self.down
    remove_column :tags, :to_be_removed
  end
end
