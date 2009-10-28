class AddTypeToOrganisations < ActiveRecord::Migration
  def self.up
    add_column :organisations, :type, :string
    add_column :organisations, :created_by_id, :integer
    add_column :organisations, :updated_by_id, :integer
  end

  def self.down
    remove_column :organisations, :type
    remove_column :organisations, :created_by_id
    remove_column :organisations, :updated_by_id
  end
end
