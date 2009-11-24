class AddHomeCountryIdToClientSetup < ActiveRecord::Migration
  def self.up
    add_column :client_setups, :home_country_id, :integer
  end

  def self.down
    remove_column :client_setups
  end
end
