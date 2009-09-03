class CreateQueryDetails < ActiveRecord::Migration
  def self.up
    create_table :query_details do |t|
      t.integer :query_header_id
      t.integer :sequence
      t.string :table_name
      t.string :field_name
      t.boolean :status
      t.string :type
    end
  end

  def self.down
    drop_table :query_details
  end
end
