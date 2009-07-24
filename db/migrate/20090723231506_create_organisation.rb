class CreateOrganisation < ActiveRecord::Migration
  def self.up
    create_table :organisations do |t|
      t.column :custom_id, :text
      t.column :full_name, :text
      t.column :short_name, :text
      t.column :trading_as, :text
      t.column :registered_name, :text
      t.column :registered_number, :text
      t.column :registered_date, :date
      t.column :registered_country_id, :integer
      t.column :organisation_type, :text
      t.column :tax_file_no, :text
      t.column :legal_no_1, :text
      t.column :legal_no_2, :text
      t.column :business_classification, :text
      t.column :business_nature, :text
      t.column :buisness_category, :text
      t.column :business_sub_category, :text
      t.column :industrial_sector, :text
      t.column :industrial_code, :text
      t.column :number_of_full_time_employees, :integer
      t.column :number_of_part_time_employees, :integer
      t.column :number_of_contractors, :integer
      t.column :number_of_volunteers, :integer
      t.column :number_of_other_workers, :integer
      t.column :business_mission, :text
      t.column :organisation_hierarchy_id, :integer
      t.column :remarks, :string
      t.timestamps
    end

    create_table :organisation_hierarchy do |t|
      t.column :heirarchy_level, :integer
      t.column :heirarchy_name, :text
      t.column :remarks, :text
      t.timestamps
    end

    create_table :organisation_key_personnel do |t|
      t.column :organisation_id, :integer
      t.column :person_id, :integer
      t.column :designation, :text
      t.column :remarks, :text
      t.timestamps
    end

    create_table :organisation_subsidiaries do |t|
      t.column :parent_id, :integer
      t.column :organisation_id, :integer
      t.column :remarks, :text
      t.timestamps
    end

  end

  def self.down
    drop_table :organisations
    drop_table :organisation_hierarchy
    drop_table :organisation_key_personnel
    drop_table :organisation_subsidiaries
  end
end
