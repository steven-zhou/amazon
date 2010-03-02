class AddIsFieldToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :is_member, :boolean
    add_column :people, :is_church, :boolean
    add_column :people, :is_donor, :boolean
    add_column :people, :is_event, :boolean
    add_column :people, :is_case, :boolean


  end

  def self.down
    remove_column :people, :is_member
    remove_column :people, :is_church
    remove_column :people, :is_donor
    remove_column :people, :is_event
    remove_column :people, :is_case

  end
end
