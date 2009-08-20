class CreatRoleConditions < ActiveRecord::Migration
  def self.up

    create_table :role_conditions do |t|
      t.integer :role_id
      t.integer :priority_number
      t.integer :doctype_id
      t.string :remarks
      
      t.timestamps
    end
  end

  def self.down
     drop_table :role_conditions
  end
end
