class AddToBeRemovedToReceiptAccountCampaignSourceClientBankAccountAndEmailTemplate < ActiveRecord::Migration
  def self.up
    add_column :receipt_accounts, :to_be_removed, :boolean
    add_column :campaigns, :to_be_removed, :boolean
    add_column :sources, :to_be_removed, :boolean
    add_column :bank_accounts, :to_be_removed, :boolean
    add_column :message_templates, :to_be_removed, :boolean
  end

  def self.down
    remove_column :receipt_accounts, :to_be_removed
    remove_column :campaigns, :to_be_removed
    remove_column :sources, :to_be_removed
    remove_column :bank_accounts, :to_be_removed
    remove_column :message_templates, :to_be_removed
  end
end
