class CreateOgansisationContactsReportGrids < ActiveRecord::Migration
  def self.up
    create_table :ogansisation_contacts_report_grids do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :ogansisation_contacts_report_grids
  end
end
