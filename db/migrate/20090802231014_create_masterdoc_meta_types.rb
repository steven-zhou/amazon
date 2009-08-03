class CreateMasterdocMetaTypes < ActiveRecord::Migration
  def self.up

    add_column :master_doc_types, :master_doc_meta_type_id, :integer

    create_table :master_doc_meta_meta_types do |t|
      t.column :name, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    create_table :master_doc_meta_types do |t|
      t.column :name, :text
      t.column :master_doc_meta_meta_type_id, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

  end

  def self.down
    remove_column :master_doc_types, :master_doc_meta_type_id
    drop_table :master_doc_meta_types
    drop_table :master_doc_meta_meta_types
  end
end
