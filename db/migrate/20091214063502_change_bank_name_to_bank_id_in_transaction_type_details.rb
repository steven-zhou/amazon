class ChangeBankNameToBankIdInTransactionTypeDetails < ActiveRecord::Migration
  def self.up
    add_column :transaction_type_details, :bank_id, :integer
    remove_column :transaction_type_details, :bsb
    remove_column :transaction_type_details, :bank_name
  end

  def self.down
    add_column :transaction_type_details, :bank_name, :string
    add_column :transaction_type_details, :bsb, :string
    remove_column :transaction_type_details, :bank_id
  end
end
