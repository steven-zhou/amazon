class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.string :label
      t.string :short_description
      t.date :alarm_date
      t.time :alarm_time
      t.boolean :active
      t.string :body_text
  
      t.integer :noteable_id
      t.string :noteable_type
      t.integer :note_type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
