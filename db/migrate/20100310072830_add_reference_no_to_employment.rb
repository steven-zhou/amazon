class AddReferenceNoToEmployment < ActiveRecord::Migration
  def self.up
    add_column :employments, :workplace_reference, :string
    add_column :employments, :union_reference, :string
    add_column :employments, :payroll_center, :string
  end

  def self.down
    remove_column :employments, :workplace_reference
    remove_column :employments, :union_reference
    remove_column :employments, :payroll_center
  end
end
