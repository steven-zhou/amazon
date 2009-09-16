class CreateListDetails < ActiveRecord::Migration
  def self.up
    create_table :list_details do |t|
      t.integer :list_header_id
      t.integer :person_id
      t.timestamps
    end
  end

  def self.down
    drop_table :list_details
  end
end
