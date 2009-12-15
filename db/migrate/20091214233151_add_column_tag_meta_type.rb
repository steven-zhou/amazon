class AddColumnTagMetaType < ActiveRecord::Migration
   def self.up
    add_column :tag_meta_types, :to_be_removed ,:boolean
  end

  def self.down
    remove_column :tag_meta_types, :to_be_removed
  end
end
