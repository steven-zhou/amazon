class CreateAvailableModules < ActiveRecord::Migration
  def self.up
    create_table :available_modules do |t|
      t.column :name, :string
      t.column :description, :string
      t.column :status, :boolean
      t.timestamps
    end
  end

  def self.down
    drop_table :available_modules
  end
end
