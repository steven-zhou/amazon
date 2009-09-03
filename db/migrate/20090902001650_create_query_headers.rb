class CreateQueryHeaders < ActiveRecord::Migration
  def self.up
    create_table :query_headers do |t|
      t.string :name
      t.string :description
      t.date :last_date_executed
      t.boolean :status
      t.boolean :save
      t.timestamps
    end
  end

  def self.down
    drop_table :query_headers
  end
end
