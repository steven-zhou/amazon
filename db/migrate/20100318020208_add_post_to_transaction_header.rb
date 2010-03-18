class AddPostToTransactionHeader < ActiveRecord::Migration
  def self.up
    add_column :transaction_headers, :post, :boolean
  end

  def self.down
    remove_column :transaction_headers, :post
  end
end
