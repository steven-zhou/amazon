class CreateGuestTable < ActiveRecord::Migration
  def self.up

    create_table :guests ,:force=>true do |t|
      t.string :first_name
      t.string :family_name
      t.column :password_hash, :text
      t.column :password_salt, :text
      t.column :phone_num, :string
      t.column :email, :string
      t.integer :creator_id
      t.integer :updater_id
      t.boolean :password_by_system
      t.timestamps
    end
  end

  def self.down
    drop_table :guests
  end
end
