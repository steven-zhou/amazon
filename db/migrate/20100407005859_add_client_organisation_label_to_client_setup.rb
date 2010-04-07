class AddClientOrganisationLabelToClientSetup < ActiveRecord::Migration
  def self.up
    add_column :client_setups, :level_0_client_default_label, :text
    add_column :client_setups, :level_1_client_default_label, :text
    add_column :client_setups, :level_2_client_default_label, :text
    add_column :client_setups, :level_3_client_default_label, :text
    add_column :client_setups, :level_4_client_default_label, :text
    add_column :client_setups, :level_5_client_default_label, :text
    add_column :client_setups, :level_6_client_default_label, :text
    add_column :client_setups, :level_7_client_default_label, :text
    add_column :client_setups, :level_8_client_default_label, :text
    add_column :client_setups, :level_9_client_default_label, :text


    add_column :client_setups, :level_0_client_label, :text
    add_column :client_setups, :level_1_client_label, :text
    add_column :client_setups, :level_2_client_label, :text
    add_column :client_setups, :level_3_client_label, :text
    add_column :client_setups, :level_4_client_label, :text
    add_column :client_setups, :level_5_client_label, :text
    add_column :client_setups, :level_6_client_label, :text
    add_column :client_setups, :level_7_client_label, :text
    add_column :client_setups, :level_8_client_label, :text
    add_column :client_setups, :level_9_client_label, :text

  end

  def self.down
    remove_column :client_setups, :level_0_client_default_label
    remove_column :client_setups, :level_1_client_default_label
    remove_column :client_setups, :level_2_client_default_label
    remove_column :client_setups, :level_3_client_default_label
    remove_column :client_setups, :level_4_client_default_label
    remove_column :client_setups, :level_5_client_default_label
    remove_column :client_setups, :level_6_client_default_label
    remove_column :client_setups, :level_7_client_default_label
    remove_column :client_setups, :level_8_client_default_label
    remove_column :client_setups, :level_9_client_default_label


    remove_column :client_setups, :level_0_client_label
    remove_column :client_setups, :level_1_client_label
    remove_column :client_setups, :level_2_client_label
    remove_column :client_setups, :level_3_client_label
    remove_column :client_setups, :level_4_client_label
    remove_column :client_setups, :level_5_client_label
    remove_column :client_setups, :level_6_client_label
    remove_column :client_setups, :level_7_client_label
    remove_column :client_setups, :level_8_client_label
    remove_column :client_setups, :level_9_client_label

  end
end
