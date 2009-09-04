class CreateQueryCriterias < ActiveRecord::Migration
  def self.up
    create_table :query_criterias do |t|
      t.integer :query_header_id
      t.integer :sequence
      t.string :table_name
      t.string :field_name
      t.string :data_type
      t.string :operator
      t.string :option
      t.string :value
      t.string :status
    end
  end

  def self.down
    drop_table :query_criterias
  end
end
