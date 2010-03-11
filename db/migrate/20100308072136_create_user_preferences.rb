class CreateUserPreferences < ActiveRecord::Migration
  def self.up
    create_table :user_preferences, :force => true do |t|
      t.integer :login_account_id
      t.date :default_start_date
      t.date :default_end_date
      t.integer :default_list_header_id
      t.integer :default_address_type_id
      t.integer :default_first_title_id
      t.integer :default_nationality_id
      t.integer :default_language_id
      t.integer :default_phone_type_id
      t.integer :default_email_type_id
      t.integer :default_website_type_id
      t.integer :default_note_type_id
      t.integer :creator_id
      t.integer :updater_id
      t.timestamps
    end
  end

  def self.down
    drop_table :user_preferences
  end
  
end
