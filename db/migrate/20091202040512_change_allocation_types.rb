class ChangeAllocationTypes < ActiveRecord::Migration
  def self.up
    add_column :allocation_types, :link_module_name, :text
  end

  def self.down
    remove_column :allocation_types, :link_module_name
  end
end
