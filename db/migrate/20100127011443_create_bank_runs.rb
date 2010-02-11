class CreateBankRuns < ActiveRecord::Migration
  def self.up
    create_table :bank_runs do |t|
      
      t.timestamps
    end
  end

  def self.down
    drop_table :bank_runs
  end
end
