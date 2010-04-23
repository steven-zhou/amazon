class CreateTaxItems < ActiveRecord::Migration
  def self.up
    create_table :tax_items, :force => true do |t|
      t.text :name
      t.text :description
      t.column :percentage, :decimal
      t.boolean :active
      t.boolean :to_be_removed
      t.integer :creator_id
      t.integer :updater_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tax_items
  end
end
