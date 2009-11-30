class CreateClientAndPersonBankAccount < ActiveRecord::Migration
  def self.up
    create_table :client_bank_accounts do |t|
      t.column :bank_id, :integer
      t.column :account_number, :text
      t.column :account_purpose_id, :integer
      t.column :status, :boolean
      t.column :remarks, :text
    end

    create_table :person_bank_accounts do |t|
      t.column :person_id, :integer
      t.column :bank_id, :integer
      t.column :account_number, :text
      t.column :account_type_id, :integer
      t.column :status, :boolean
      t.column :remarks, :text
    end

  end

  def self.down
    drop_table :client_bank_accounts
    drop_table :person_bank_accounts
  end
end
