class AddColumnToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :monday_hours, :string
    add_column :contacts, :tuesday_hours, :string
    add_column :contacts, :wednesday_hours, :string
    add_column :contacts, :thursday_hours, :string
    add_column :contacts, :friday_hours, :string
    add_column :contacts, :saturday_hours, :string
    add_column :contacts, :sunday_hours, :string
  end

  def self.down
    remove_column :contacts,:monday_hours
    remove_column :contacts,:tuesday_hours
    remove_column :contacts,:wednesday_hours
    remove_column :contacts,:thursday_hours
    remove_column :contacts,:friday_hours
    remove_column :contacts,:saturday_hours
    remove_column :contacts,:sunday_hours
  end
end
