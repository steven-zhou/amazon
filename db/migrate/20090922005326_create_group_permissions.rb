class CreateGroupPermissions < ActiveRecord::Migration
  def self.up
    create_table :group_permissions do |t|
      t.column :system_permission_type_id, :integer
      t.column :user_group_id, :integer
    end

  end

  def self.down
    drop_table :group_permissions
  end
end
