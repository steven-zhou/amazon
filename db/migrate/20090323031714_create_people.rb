class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :custom_id
      t.integer :title_id
      t.integer :second_title_id
      t.string :first_name
      t.string :middle_name
      t.string :family_name
      t.string :maiden_name
      t.string :preferred_name
      t.string :initials
      t.string :post_title
      t.string :gender
      t.string :marital_status
      t.date :birth_date
      t.string :primary_salutation
      t.string :second_salutation
      t.integer :industry_sector
      t.string :interests
      t.integer :origin_country_id
      t.integer :residence_country_id
      t.integer :nationality_id
      t.integer :other_nationality_id
      t.integer :language_id
      t.integer :other_language_id
      t.integer :religion_id
      t.string :view_name
      t.string :picture_path
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.date :onrecord_since

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end

