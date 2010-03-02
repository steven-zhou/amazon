class CreateFeeItems < ActiveRecord::Migration
  def self.up
    create_table :fee_items do |t|
      t.integer :tag_type_id
      t.string :type
      t.text :name
      t.text :destription
      t.integer :tax_items_id
      t.string :GL_Code

      t.column :amount, :decimal, :precision => 11, :scale => 3
      t.string :payment_frequency_id
      t.integer :link_module_id
      t.column :starting_date, :datetime
      t.column :ending_date, :datetime
      t.boolean :active
      t.boolean :to_be_removed

      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fee_items
  end
end
