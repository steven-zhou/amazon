class AddModuleToQuickLaunchIcons < ActiveRecord::Migration
  def self.up
    add_column :quick_launch_icons, :module, :text


  end

  def self.down
     remove_column :quick_launch_icons, :module
  end
end
