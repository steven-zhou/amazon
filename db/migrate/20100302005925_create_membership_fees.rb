class CreateMembershipFees < ActiveRecord::Migration
  def self.up
    create_table :membership_fees, :force => true  do |t|
      t.integer :membership_id
      t.integer :payment_method_id
      t.integer :fee_item_id
      t.integer :receipt_account_id
      t.boolean :active
      t.integer :creator_id
      t.integer :updater_id
      t.timestamps
    end
  end

  def self.down
    drop_table :membership_fees
  end
end
