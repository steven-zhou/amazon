class Addnewcolumntobulkemail < ActiveRecord::Migration
  def self.up
    add_column :bulk_emails,:type,:string
  end

  def self.down
    remove_column :bulk_emails,:type
  end
end
