class CreateOrganisationRelationships < ActiveRecord::Migration
  def self.up
    create_table :organisation_relationships do |t|
      t.integer :source_organisation_id
      t.integer :related_organisation_id
      t.string  :remarks
      t.timestamps
    end
  end

  def self.down
     drop_table :organisation_relationships
  end
end
