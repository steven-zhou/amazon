class CreateFeedback < ActiveRecord::Migration
  def self.up
    create_table :feedback_items do |t|
      t.column :login_account_id, :integer
      t.column :subject, :text
      t.column :content, :text
      t.column :ip_address, :text
      t.column :status, :text
      t.column :feedback_date, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :feedback_items
  end
end
