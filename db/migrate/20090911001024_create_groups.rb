class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.column :tags_id, :integer
      t.column :name, :string
      t.column :description, :string
      t.column :status, :boolean
      t.column :group_owner, :integer
      t.column :start_date, :date
      t.column :end_date, :date
      t.timestamps

    end
  end

  def self.down
    drop_table :groups
  end
end
