class RenameColumnFromCountry < ActiveRecord::Migration
  def self.up
    rename_column :countries, :ISO_code, :iso_code
  end

  def self.down
    rename_column :countries, :iso_code, :ISO_code
  end
end
