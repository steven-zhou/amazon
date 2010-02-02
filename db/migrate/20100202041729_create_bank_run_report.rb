class CreateBankRunReport < ActiveRecord::Migration
  def self.up
     create_table :bank_run_reports do |t|
      t.integer :client_organisation_id
      t.integer :bank_run_id
      t.integer :bank_account_id
      t.column :type, :string
      t.timestamps
    end
  end

  def self.down
     drop_table :bank_run_reports
  end
end
