class CreateTags < ActiveRecord::Migration
  def self.up

    drop_table :master_doc_types
    drop_table :master_doc_meta_types
    drop_table :master_doc_meta_meta_types

    create_table :tag_meta_types do |t|
      t.column :name, :text
      t.column :description, :text
      t.column :position, :integer
      t.column :status, :boolean
      t.column :type, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    create_table :tag_types do |t|
      t.column :name, :text
      t.column :tag_meta_type_id, :integer
      t.column :description, :text
      t.column :position, :integer
      t.column :status, :boolean
      t.column :type, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    create_table :tags do |t|
      t.column :name, :text
      t.column :tag_type_id, :integer
      t.column :description, :text
      t.column :position, :integer
      t.column :status, :boolean
      t.column :type, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

  end

  def self.down

    create_table "master_doc_meta_meta_types", :force => true do |t|
      t.text     "name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "description"
      t.boolean  "status"
    end

    create_table "master_doc_meta_types", :force => true do |t|
      t.text     "name"
      t.integer  "master_doc_meta_meta_type_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "description"
      t.boolean  "status"
    end

    create_table "master_doc_types", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "master_doc_meta_type_id"
      t.text     "description"
      t.boolean  "status"
    end
  
    drop_table :tag_meta_types
    drop_table :tag_types
    drop_table :tags
  end
end
