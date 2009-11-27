class CreateReceiptAccountsAndReceiptMethods < ActiveRecord::Migration
  def self.up
    create_table :receipt_accounts do |t|
      t.column :name, :text
      t.column :description, :text
      t.column :receipt_account_type_id, :integer
      t.column :post_to_history, :boolean
      t.column :post_to_campaign, :boolean
      t.column :send_receipt, :boolean
      t.column :status, :boolean
      t.column :remarks, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    create_table :receipt_methods do |t|
      t.column :name, :text
      t.column :description, :text
      t.column :receipt_method_type_id, :integer
      t.column :status, :boolean
      t.column :remarks, :text
      t.column :card_merchant_number, :text
      t.column :card_name, :text
      t.column :card_location, :text
      t.column :card_cost, :text
      t.column :card_floor_limit, :text
      t.column :card_lines_per_page, :integer
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

  end

  def self.down
    drop_table :receipt_accounts
    drop_table :receipt_methods
  end
end
