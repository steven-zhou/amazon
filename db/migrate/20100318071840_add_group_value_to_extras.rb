class AddGroupValueToExtras < ActiveRecord::Migration
  def self.up
    add_column :extras, :group_value, :string
  end

  def self.down
    remove_column :extras, :group_value
  end
end
