class ModifyPostcodes < ActiveRecord::Migration
  def self.up
    remove_column :postcodes, :type
  end

  def self.down
    # This is not really a migration you can "undo" as you've now deleted the STI info, but what the heck, I'll let you do it anyway....
    add_column :postcodes, :type, :text
  end
end
