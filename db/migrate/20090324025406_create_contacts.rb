class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :pre_value
      t.string :value
      t.string :post_value
      t.string :preferred_time
      t.string :preferred_day
      t.string :remarks
      t.string :type
      t.integer :contactable_id
      t.string :contactable_type
      t.integer :contact_type_id
      t.boolean :priority

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end