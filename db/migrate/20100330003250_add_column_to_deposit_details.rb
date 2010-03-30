class AddColumnToDepositDetails < ActiveRecord::Migration
  def self.up
    add_column :deposit_details,:card_authority_number, :string
  end

  def self.down
    remove_column :deposit_details
  end
end
