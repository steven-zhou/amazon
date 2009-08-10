class AddStatusToEmployment < ActiveRecord::Migration
  def self.up
    add_column :employments, :status, :boolean
  end

  def self.down
    remove_column :employments, :status
  end
end
