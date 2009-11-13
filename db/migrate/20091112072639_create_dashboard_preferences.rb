class CreateDashboardPreferences < ActiveRecord::Migration
  def self.up
    create_table :dashboard_preferences do |t|
      t.column :login_account_id, :integer
      t.column :column_id, :integer
      t.column :box_id, :integer
    end
  end

  def self.down
    drop_table :dashboard_preferences
  end
end
