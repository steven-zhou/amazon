class ChangesToClientSetups < ActiveRecord::Migration

  def self.up
    remove_column :client_setups, :primary_password_hash
    remove_column :client_setups, :primary_password_salt
    remove_column :client_setups, :secondary_password_hash
    remove_column :client_setups, :secondary_password_salt
    remove_column :client_setups, :security_question1_id
    remove_column :client_setups, :security_question2_id
    remove_column :client_setups, :security_question3_id
    remove_column :client_setups, :question1_answer
    remove_column :client_setups, :question2_answer
    remove_column :client_setups, :question3_answer
    add_column :client_setups, :member_zone_power_password_hash, :text
    add_column :client_setups, :member_zone_power_password_salt, :text
    add_column :client_setups, :super_admin_power_password_hash, :text
    add_column :client_setups, :super_admin_power_password_salt, :text
  end

  def self.down
    add_column :client_setups, :primary_password_hash, :text
    add_column :client_setups, :primary_password_salt, :text
    add_column :client_setups, :secondary_password_hash, :text
    add_column :client_setups, :secondary_password_salt, :text
    add_column :client_setups, :security_question1_id, :integer
    add_column :client_setups, :security_question2_id, :integer
    add_column :client_setups, :security_question3_id, :integer
    add_column :client_setups, :question1_answer, :text
    add_column :client_setups, :question2_answer, :text
    add_column :client_setups, :question3_answer, :text
    remove_column :client_setups, :member_zone_power_password_hash
    remove_column :client_setups, :member_zone_power_password_salt
    remove_column :client_setups, :super_admin_power_password_hash
    remove_column :client_setups, :super_admin_power_password_salt
  end
end
