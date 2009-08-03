class CreateContactMetaTypes < ActiveRecord::Migration
  def self.up
    create_table :contact_meta_types do |t|
      t.column :name, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    remove_column :contact_types, :metatype
    add_column :contact_types, :contact_meta_type_id, :integer

  end


  def self.down
    drop_table :contact_meta_types
    add_column :contact_types, :metatype, :string
    remove_column :contact_types, :contact_meta_type_id
  end
end
