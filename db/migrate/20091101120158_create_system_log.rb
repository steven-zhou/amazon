class CreateSystemLog < ActiveRecord::Migration
  def self.up
    create_table :system_logs do |t|
      t.column :user_id, :integer
      t.column :message, :text
      t.column :controller, :text
      t.column :action, :text
      t.column :ip_address, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime

    end
  end

  def self.down
    drop_table :system_logs
  end
end
