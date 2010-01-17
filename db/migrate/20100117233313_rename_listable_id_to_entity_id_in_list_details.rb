class RenameListableIdToEntityIdInListDetails < ActiveRecord::Migration
  def self.up
    rename_column :list_details, :listable_id, :entity_id
  end

  def self.down
    rename_column :list_details, :entity_id, :listable_id
  end
end
