class CreateCompileLists < ActiveRecord::Migration
  def self.up
    create_table :compile_lists do |t|
      t.integer :login_account_id
      t.integer :list_header_id
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :compile_lists
  end
end
