class RenameAndAddColumnListDetails < ActiveRecord::Migration
 def self.up
    rename_column :list_details, :person_id, :listable_id
   add_column :list_details, :listable_type, :string
  end

  def self.down
    rename_column :list_details, :listable_id, :person_id
    remove_column :list_details,:listable_type
  end
end
