class AddToberemovedColumnToAmazonSetting < ActiveRecord::Migration
  def self.up
    add_column :amazon_setting, :to_be_removed, :boolean
  end

  def self.down
    remove_column :amazon_setting, :to_be_removed
  end
end
