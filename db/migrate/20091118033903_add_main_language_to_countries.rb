class AddMainLanguageToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :main_language, :string
  end

  def self.down
    remove_column :countries, :main_language
  end
end
