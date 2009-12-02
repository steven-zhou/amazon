class ModifyClientSetupAddOrganisationHierarchy < ActiveRecord::Migration
  def self.up
    add_column :client_setups, :level_0_label, :text
    add_column :client_setups, :level_0_remarks, :text
    add_column :client_setups, :level_1_label, :text
    add_column :client_setups, :level_1_remarks, :text
    add_column :client_setups, :level_2_label, :text
    add_column :client_setups, :level_2_remarks, :text
    add_column :client_setups, :level_3_label, :text
    add_column :client_setups, :level_3_remarks, :text
    add_column :client_setups, :level_4_label, :text
    add_column :client_setups, :level_4_remarks, :text
    add_column :client_setups, :level_5_label, :text
    add_column :client_setups, :level_5_remarks, :text
    add_column :client_setups, :level_6_label, :text
    add_column :client_setups, :level_6_remarks, :text
    add_column :client_setups, :level_7_label, :text
    add_column :client_setups, :level_7_remarks, :text
    add_column :client_setups, :level_8_label, :text
    add_column :client_setups, :level_8_remarks, :text
    add_column :client_setups, :level_9_label, :text
    add_column :client_setups, :level_9_remarks, :text
  end

  def self.down
    remove_column :client_setups, :level_0_label
    remove_column :client_setups, :level_0_remarks
    remove_column :client_setups, :level_1_label
    remove_column :client_setups, :level_1_remarks
    remove_column :client_setups, :level_2_label
    remove_column :client_setups, :level_2_remarks
    remove_column :client_setups, :level_3_label
    remove_column :client_setups, :level_3_remarks
    remove_column :client_setups, :level_4_label
    remove_column :client_setups, :level_4_remarks
    remove_column :client_setups, :level_5_label
    remove_column :client_setups, :level_5_remarks
    remove_column :client_setups, :level_6_label
    remove_column :client_setups, :level_6_remarks
    remove_column :client_setups, :level_7_label
    remove_column :client_setups, :level_7_remarks
    remove_column :client_setups, :level_8_label
    remove_column :client_setups, :level_8_remarks
    remove_column :client_setups, :level_9_label
    remove_column :client_setups, :level_9_remarks
  end
end
