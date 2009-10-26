class CreateToDoLists < ActiveRecord::Migration
  def self.up
    create_table :to_do_lists do |t|
      t.column :description, :text
      t.column :status, :string
      t.column :due_date, :datetime
      t.column :created_by_id, :integer
      t.column :updated_by_id, :integer
      t.column :login_account_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :to_do_lists
  end
end
