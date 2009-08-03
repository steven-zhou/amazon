class CreateAmazonSettings < ActiveRecord::Migration
  def self.up

    create_table :amazon_settings do |t|
      t.column :name, :string
      t.column :position, :integer
      t.column :type, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    rename_column :people, :title_id, :primary_title_id
    rename_column :people, :industry_sector, :industry_sector_id

    remove_column :people, :marital_status
    add_column :people, :marital_status_id, :integer
    remove_column :people, :gender
    add_column :people, :gender_id, :integer
    remove_column :master_docs, :issue_country
    add_column :master_docs, :issue_country_id, :integer

    remove_column :people, :view_name

    drop_table :titles
    drop_table :title_types
    drop_table :address_types
    drop_table :keyword_types
    drop_table :note_types
    drop_table :relationship_types
    drop_table :religions
    drop_table :role_types
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
