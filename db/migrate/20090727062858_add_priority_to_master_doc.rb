class AddPriorityToMasterDoc < ActiveRecord::Migration
  def self.up
    add_column :master_docs, :priority_number, :integer
  end

  def self.down
    remove_column :master_docs, :priority_number
  end
end
