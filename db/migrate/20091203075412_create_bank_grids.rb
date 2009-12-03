class CreateBankGrids < ActiveRecord::Migration
  def self.up
    create_table :bank_grids do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bank_grids
  end
end
