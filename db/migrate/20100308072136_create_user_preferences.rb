class CreateUserPreferences < ActiveRecord::Migration
  def self.up
    create_table :user_preferences, :force => true do |t|
      t.integer :login_account_id
      t.date :start_date
      t.date :end_date
      t.integer :address_type_id
      t.integer :first_title_id
      t.integer :nationality_id
      t.integer :language_id
      t.integer :phone_type_id
      t.integer :email_type_id
      t.integer :website_type_id
      t.integer :note_type_id
      t.integer :creator_id
      t.integer :updater_id
      t.timestamps
    end
  end

  def self.down
    drop_table :user_preferences
  end
  
end
