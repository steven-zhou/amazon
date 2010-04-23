class AddWorkplaceIdToEmployment < ActiveRecord::Migration
  def self.up
    add_column :employments, :workplace_id, :integer
  end

  def self.down
    remove_column :employments, :workplace_id
  end
end