class ChangePersonRole < ActiveRecord::Migration
  def self.up

    add_column :person_roles, :supervised_by, :integer
    add_column :person_roles, :managed_by, :integer
  end

  def self.down
    remove_column :person_roles, :supervised_by
    remove_column :person_roles, :managed_by
  end
end
