class CreateExtras < ActiveRecord::Migration
  def self.up
    create_table :extras, :force => true do |t|
      t.integer :entity_id
      t.integer :group_id
      t.string  :entity_type
      t.integer :label1_id
      t.string  :label1_value
      t.integer :label2_id
      t.string  :label2_value
      t.integer :label3_id
      t.string  :label3_value
      t.integer :label4_id
      t.string  :label4_value
      t.integer :label5_id
      t.string  :label5_value
      t.integer :label6_id
      t.string  :label6_value
      t.boolean :active
      t.integer :creator_id
      t.integer :updater_id
      t.timestamps
    end

  end

  def self.down
    drop_table :extras
  end
end
