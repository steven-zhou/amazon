class AddColumnsToPersonTable < ActiveRecord::Migration
  def self.up
    add_column :people, :primary_phone_num, :string
    add_column :people, :primary_email_address, :string

  end

  def self.down
    remove_column :people, :primary_phone_num
    remove_column :people, :primary_email_address
  end
end
