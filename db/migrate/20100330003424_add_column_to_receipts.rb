class AddColumnToReceipts < ActiveRecord::Migration
  def self.up
    add_column :receipts ,:receipt_post, :boolean
  end

  def self.down
    remove_column :receipts , :receipt_post
  end
end
