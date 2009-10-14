class CreateShowOrganisationListGrids < ActiveRecord::Migration
  def self.up
    create_table :show_organisation_list_grids do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :show_organisation_list_grids
  end
end
