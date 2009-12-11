class BulkEmailQueue < ActiveRecord::Migration
  def self.up
    create_table :bulk_emails do |t|
      t.column :subject, :text
      t.column :from, :text
      t.column :to, :text
      t.column :body, :text
      t.column :dispatch_date, :datetime
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :bulk_emails
  end
end
