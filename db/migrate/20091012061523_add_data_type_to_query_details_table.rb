class AddDataTypeToQueryDetailsTable < ActiveRecord::Migration
  def self.up
    add_column :query_details, :data_type, :string
    remove_column :query_criterias, :status
    add_column :query_criterias, :status, :boolean
  end

  def self.down
    remove_column :query_details, :data_type
    remove_column :query_criterias, :status
    add_column :query_criterias, :status, :string
  end
end
