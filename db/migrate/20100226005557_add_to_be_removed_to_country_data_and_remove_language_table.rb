class AddToBeRemovedToCountryDataAndRemoveLanguageTable < ActiveRecord::Migration
  def self.up
    drop_table :languages
    add_column :countries, :status, :boolean
    add_column :countries, :to_be_removed, :boolean
    add_column :countries, :iso_number, :string
    add_column :postcodes, :status, :boolean
    add_column :postcodes, :to_be_removed, :boolean
    add_column :post_areas, :status, :boolean
    add_column :post_areas, :to_be_removed, :boolean
    add_column :message_templates, :status, :boolean
  end

  def self.down
    create_table :languages do |t|
      t.timestamps
    end
    remove_column :countries, :status
    remove_column :countries, :to_be_removed
    remove_column :countries, :iso_number
    remove_column :postcodes, :status
    remove_column :postcodes, :to_be_removed
    remove_column :post_areas, :status
    remove_column :post_areas, :to_be_removed
    remove_column :message_templates, :status
  end
end
