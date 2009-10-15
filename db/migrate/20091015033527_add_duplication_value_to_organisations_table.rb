class AddDuplicationValueToOrganisationsTable < ActiveRecord::Migration
  def self.up
    add_column :organisations, :duplication_value, :string
  end

  def self.down
    remove_column :organisations, :duplication_value
  end
end
