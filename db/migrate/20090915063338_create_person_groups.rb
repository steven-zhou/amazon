class CreatePersonGroups < ActiveRecord::Migration
  def self.up
    create_table :person_groups do |t|

      t.integer :people_id
      t.integer :tag_id


      t.timestamps
    end
  end

  def self.down
    drop_table :person_groups
  end
end
