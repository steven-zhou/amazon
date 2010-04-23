class AddDefaultLabelsToClientSetUp < ActiveRecord::Migration
  def self.up
    add_column :client_setups, :level_0_default_label, :text
    add_column :client_setups, :level_1_default_label, :text
    add_column :client_setups, :level_2_default_label, :text
    add_column :client_setups, :level_3_default_label, :text
    add_column :client_setups, :level_4_default_label, :text
    add_column :client_setups, :level_5_default_label, :text
    add_column :client_setups, :level_6_default_label, :text
    add_column :client_setups, :level_7_default_label, :text
    add_column :client_setups, :level_8_default_label, :text
    add_column :client_setups, :level_9_default_label, :text
   
  end

  def self.down
    remove_column :client_setups, :level_0_default_label
    remove_column :client_setups, :level_1_default_label
    remove_column :client_setups, :level_2_default_label
    remove_column :client_setups, :level_3_default_label
    remove_column :client_setups, :level_4_default_label
    remove_column :client_setups, :level_5_default_label
    remove_column :client_setups, :level_6_default_label
    remove_column :client_setups, :level_7_default_label
    remove_column :client_setups, :level_8_default_label
    remove_column :client_setups, :level_9_default_label
   
  end
end
