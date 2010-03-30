class ChangeColumnToDeposit < ActiveRecord::Migration
  def self.up
    rename_column :deposits, :banked,:already_banked
    rename_column :deposits, :deposit_date,:business_date

    remove_column :deposits, :todays_date
    remove_column :deposits, :post

    add_column :deposits ,:system_time ,:datetime
    add_column :deposits, :to_be_banked, :boolean
    add_column :deposits, :bank_run_date, :date

  end

  def self.down
    rename_column :deposits,:already_banked, :banked
    rename_column :deposits,:business_date, :deposit_date
    add_column :deposits, :todays_date
    add_column :deposits, :post
    remove_column :deposits ,:system_time
    remove_column :deposits, :to_be_banked
    remove_column :deposits, :bank_run_date
  end
end
