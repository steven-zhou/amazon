class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :source_person_id
      t.integer :related_person_id
      t.integer :relationship_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
