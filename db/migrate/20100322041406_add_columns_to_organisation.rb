class AddColumnsToOrganisation < ActiveRecord::Migration
  def self.up
    add_column :organisations, :primary_phone_num, :string
    add_column :organisations, :primary_email_address, :string

  end

  def self.down
    remove_column :organisations, :primary_phone_num
    remove_column :organisations, :primary_email_address
  end
end
