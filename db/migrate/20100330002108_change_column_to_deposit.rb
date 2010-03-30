class ChangeColumnToDeposit < ActiveRecord::Migration
  def self.up
    rename_column :deposits, :banked,:already_banked
    rename_column :deposits, :deposit_date,:business_date
    
    add_column :deposits, :to_be_removed, :boolean


  end

  def self.down
  end
end
