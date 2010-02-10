class CreateHelp < ActiveRecord::Migration
  def self.up
    create_table :helps do |t|
      t.string :controller
      t.string :action
      t.string :title
      t.string :keyword
      t.string :content
    end
  end

  def self.down
    drop_table :helps
  end
end
