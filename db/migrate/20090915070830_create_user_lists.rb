class CreateUserLists < ActiveRecord::Migration
  def self.up
    create_table :user_lists do |t|
      t.integer :user_id
      t.integer :list_header_id
    end
  end

  def self.down
    drop_table :user_lists
  end
end
