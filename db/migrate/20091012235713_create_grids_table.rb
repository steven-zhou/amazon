class CreateGridsTable < ActiveRecord::Migration
  def self.up
    create_table :grids do |t|
      t.column :login_account_id, :integer
      t.column :grid_object_id, :integer
      t.column :type, :string
      t.column :field_1, :text
      t.column :field_2, :text
      t.column :field_3, :text
      t.column :field_4, :text
      t.column :field_5, :text
      t.column :field_6, :text
      t.column :field_7, :text
      t.column :field_8, :text
      t.column :field_9, :text
      t.column :field_10, :text
    end
  end

  def self.down
    drop_table :grids
  end
end
