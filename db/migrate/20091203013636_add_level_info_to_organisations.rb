class AddLevelInfoToOrganisations < ActiveRecord::Migration
  def self.up
    add_column :organisations, :level, :integer
    add_column :organisations, :level_label, :string
  end

  def self.down
    remove_column :organisations, :level, :integer
    remove_column :organisations, :level_label, :string
  end
end
