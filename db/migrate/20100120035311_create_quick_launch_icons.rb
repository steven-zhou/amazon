class CreateQuickLaunchIcons < ActiveRecord::Migration
  def self.up
    create_table :quick_launch_icons, :force => true do |t|
      t.column :controller, :text
      t.column :action, :text
      t.column :image_url, :text
      t.column :title, :text
      t.column :sequence, :integer
      t.column :login_account_id, :integer
      t.timestamps

    end
  end

  def self.down
    drop_table :quick_launch_icons
  end
end
