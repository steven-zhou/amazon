class CreateQueryHeaders < ActiveRecord::Migration
  def self.up
    create_table :query_headers do |t|
      t.string :name
      t.string :description
      t.date :last_date_executed
      t.integer :result_size
      t.boolean :status
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :query_headers
  end
end
