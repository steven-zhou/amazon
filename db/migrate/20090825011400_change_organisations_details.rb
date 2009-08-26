class ChangeOrganisationsDetails < ActiveRecord::Migration
  def self.up
    remove_column :organisations, :organisation_type
    remove_column :organisations, :business_classification
    remove_column :organisations, :business_nature
    remove_column :organisations, :industrial_sector
    remove_column :organisations, :business_category
    remove_column :organisations, :business_sub_category

    add_column :organisations, :organisation_type_id, :integer
    add_column :organisations, :business_type_id, :integer
    add_column :organisations, :industry_sector_id, :integer
    add_column :organisations, :business_category_id, :integer
  end

  def self.down
    remove_column :organisations, :organisation_type_id
    remove_column :organisations, :business_type_id
    remove_column :organisations, :industry_sector_id
    remove_column :organisations, :business_category_id

    add_column :organisations, :organisation_type, :text
    add_column :organisations, :business_classification, :text
    add_column :organisations, :business_nature, :text
    add_column :organisations, :industrial_sector, :text
    add_column :organisations, :business_category, :text
    add_column :organisations, :business_sub_category, :text
  end
end
