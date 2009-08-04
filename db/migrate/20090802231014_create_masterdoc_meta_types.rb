class CreateMasterdocMetaTypes < ActiveRecord::Migration
  def self.up


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

    add_column :master_doc_types, :master_doc_meta_type_id, :integer

    add_column :master_doc_meta_meta_types, :description, :text
    add_column :master_doc_meta_meta_types, :status, :boolean

    add_column :master_doc_meta_types, :description, :text
    add_column :master_doc_meta_types, :status, :boolean

    add_column :master_doc_types, :description, :text
    add_column :master_doc_types, :status, :boolean


  end

  def self.down
    remove_column :master_doc_types, :master_doc_meta_type_id

    drop_table :master_doc_meta_types
    drop_table :master_doc_meta_meta_types

    remove_column :master_doc_meta_meta_types, :description
    remove_column :master_doc_meta_meta_types, :status

    remove_column :master_doc_meta_types, :description
    remove_column :master_doc_meta_types, :status

    remove_column :master_doc_types, :description
    remove_column :master_doc_types, :status

  end
end
