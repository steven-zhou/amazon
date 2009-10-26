class CreatePersonLookupGrids < ActiveRecord::Migration
  def self.up
    create_table :person_lookup_grids do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :person_lookup_grids
  end
end
