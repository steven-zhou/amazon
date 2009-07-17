class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string "long_name"
      t.string "short_name"
      t.string "citizenship"
      t.string "capital"
      t.string "ISO_code"
      t.string "currency"
      t.string "currency_subunit"
      t.integer "main_language_id"
      t.timestamps
    end

  end

  def self.down
    drop_table :countries
  end
end
