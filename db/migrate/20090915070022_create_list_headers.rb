class CreateListHeaders < ActiveRecord::Migration
  def self.up
      create_table :list_headers do |t|
        t.integer :query_header_id
        t.string :type
        t.string :name
        t.string :description
        t.integer :list_size
        t.date :last_date_generated
        t.boolean :status

        t.timestamps
      end
  end

  def self.down
    drop_table :list_headers
  end
end
