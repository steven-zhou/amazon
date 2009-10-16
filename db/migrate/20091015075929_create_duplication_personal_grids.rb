class CreateDuplicationPersonalGrids < ActiveRecord::Migration
  def self.up
    create_table :duplication_personal_grids do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :duplication_personal_grids
  end
end
