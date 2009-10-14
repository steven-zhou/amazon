class CreateShowOrganisationGrids < ActiveRecord::Migration
  def self.up
    create_table :show_organisation_grids do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :show_organisation_grids
  end
end
