class CreateKeywords < ActiveRecord::Migration
  def self.up
    create_table :keywords do |t|
      t.string :name
      t.string :description
      t.boolean :status
      t.integer :keyword_type_id
      
      t.timestamps
    end
    
  end

  def self.down
    drop_table :keywords
  end
end