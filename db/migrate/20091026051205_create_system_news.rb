class CreateSystemNews < ActiveRecord::Migration
  def self.up
    create_table :system_news do |t|
      t.column :description, :text
      t.column :event_date, :datetime
      t.column :created_by_id, :integer
      t.column :updated_by_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :system_news
  end
end
