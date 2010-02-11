class CreateBankRuns < ActiveRecord::Migration
  def self.up
    create_table :bank_runs, :force => true do |t|
      
      t.timestamps
    end
  end

  def self.down
    drop_table :bank_runs
  end
end
