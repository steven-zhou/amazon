class ModifyBulkEmail < ActiveRecord::Migration
  def self.up
    add_column :bulk_emails, :to_be_removed, :boolean, :default => false
    add_column :bulk_emails, :status, :boolean, :default => true

  end

  def self.down
    remove_column :bulk_emails, :to_be_removed
    remove_column :bulk_emails, :status
  end
end
