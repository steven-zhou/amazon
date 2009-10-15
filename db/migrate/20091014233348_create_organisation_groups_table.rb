class CreateOrganisationGroupsTable < ActiveRecord::Migration
  def self.up
    create_table :organisation_groups do |t|
      t.column :organisation_id, :integer
      t.column :tag_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :organisation_groups
  end
end
