class AddDialupCodeToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :dialup_code, :string
  end

  def self.down
    remove_column :countries, :dialup_code
  end
end
