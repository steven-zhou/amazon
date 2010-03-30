class ChangeColumnToDepositTable < ActiveRecord::Migration
  def self.up
    rename_column :deposits, :banked,:already_banked
    rename_column :deposits, :deposit_date,:business_date
    remove_column :deposits, :todays_date
    remove_column :deposits, :post
    add_column :deposits ,:system_time ,:datetime
    add_column :deposits, :to_be_banked, :boolean
    add_column :deposits, :bank_run_date, :date
    add_column :deposit_details,:card_authority_number, :string
    add_column :receipts ,:receipt_post, :boolean

    remove_column :receipts, :manual_receipt_number
    add_column :receipts, :manual_receipt_number, :string

  end

  def self.down
    rename_column :deposits,:already_banked, :banked
    rename_column :deposits,:business_date, :deposit_date
    add_column :deposits, :todays_date ,:date
    add_column :deposits, :post, :boolean
    remove_column :deposits ,:system_time
    remove_column :deposits, :to_be_banked
    remove_column :deposits, :bank_run_date
    remove_column :deposit_details,:card_authority_number
    remove_column :receipts , :receipt_post
    remove_column :receipts, :manual_receipt_number
    add_column :receipts, :manual_receipt_number, :integer
    
  end
end
