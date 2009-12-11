class AddToberemoveColumnToKeyword < ActiveRecord::Migration
  def self.up
    add_column :keywords, :to_be_removed ,:boolean
  end

  def self.down
    remove_column :keywords, :to_be_removed
  end
end
