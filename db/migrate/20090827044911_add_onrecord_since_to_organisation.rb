class AddOnrecordSinceToOrganisation < ActiveRecord::Migration
  def self.up
    add_column :organisations, :onrecord_since, :date
  end

  def self.down
    remove_column :organisations, :onrecord_since
  end
end
