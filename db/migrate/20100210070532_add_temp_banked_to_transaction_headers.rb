class AddTempBankedToTransactionHeaders < ActiveRecord::Migration
  def self.up
    add_column :transaction_headers, :temp_banked, :boolean
  end

  def self.down
    remove_column :transaction_headers, :temp_banked
  end
end
