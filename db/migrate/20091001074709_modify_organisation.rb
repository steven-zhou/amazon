class ModifyOrganisation < ActiveRecord::Migration
  def self.up
    add_column :organisations, :business_sub_category, :string
    
  end

  def self.down
    remove_column :organisations, :business_sub_category
  
  end
end
