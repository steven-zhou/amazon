class AddTitleToSystemNews < ActiveRecord::Migration
  def self.up
    add_column :system_news, :title, :string
  end

  def self.down
    remove_column :system_news
  end
end
