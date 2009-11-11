class ChangeMessageToSuperAdminToSuperadminMessage < ActiveRecord::Migration
  def self.up
    remove_column :client_setups, :message_to_super_admin
    add_column :client_setups, :superadmin_message, :string
    add_column :client_setups, :feedback_to, :string
    add_column :client_setups, :reply_from, :string
  end

  def self.down
    remove_column :client_setups, :superadmin_message
    add_column :client_setups, :message_to_super_admin, :string
    remove_column :client_setups, :feedback_to
    remove_column :client_setups, :reply_from
  end
end
