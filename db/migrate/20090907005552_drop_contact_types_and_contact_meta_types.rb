class DropContactTypesAndContactMetaTypes < ActiveRecord::Migration
  def self.up
    drop_table :contact_meta_types
    drop_table :contact_types

    remove_column :contacts, :contact_type_id
    add_column :contacts, :contact_meta_type_id, :integer
  end

  def self.down
    create_table :contact_types do |t|
      t.string :name
      t.string :metatype

      t.timestamps
    end

    create_table :contact_meta_types do |t|
      t.column :name, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    remove_column :contacts, :contact_meta_type_id
    add_column :contacts, :contact_type_id, :integer
  end
end
