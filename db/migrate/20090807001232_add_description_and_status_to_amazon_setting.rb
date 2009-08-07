class AddDescriptionAndStatusToAmazonSetting < ActiveRecord::Migration
  def self.up
    add_column :amazon_settings, :description, :string
    add_column :amazon_settings, :status, :boolean
  end

  def self.down
    remove_column :amazon_settings, :description
    remove_column :amazon_settings, :status
  end
end
