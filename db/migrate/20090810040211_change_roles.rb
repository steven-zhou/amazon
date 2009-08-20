class ChangeRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :description, :string
    add_column :roles, :remarks, :string
    add_column :roles, :role_status, :boolean
  end

  def self.down
    remove_column :roles, :description
    remove_column :roles, :remarks
    remove_column :roles, :role_status
  end
end
