class ChangeMainLanguageToGovenmentLanguage < ActiveRecord::Migration
  def self.up
    add_column :countries, :govenment_language, :string
    remove_column :countries, :main_language
  end

  def self.down
    remove_column :countries, :govenment_language
    add_column :countries, :main_language, :string
  end
end
