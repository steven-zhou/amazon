class CreateNewColumnFromQueryHeader < ActiveRecord::Migration
   def self.up
    add_column :query_headers , :type,:string
  end

  def self.down
    remove_column :query_headers , :type
  end
end
