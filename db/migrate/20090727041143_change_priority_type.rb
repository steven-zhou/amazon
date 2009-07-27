class ChangePriorityType < ActiveRecord::Migration
  def self.up
    remove_column :addresses, :priority
    remove_column :contacts, :priority
    add_column :addresses, :priority_number, :integer
    add_column :contacts, :priority_number, :integer
  end

  def self.down
    remove_column :addresses, :priority_number
    remove_column :contacts, :priority_number
    add_column :addresses, :priority, :boolean
    add_column :contacts, :priority, :boolean
  end
end
