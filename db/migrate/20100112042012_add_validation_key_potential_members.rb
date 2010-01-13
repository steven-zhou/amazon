class AddValidationKeyPotentialMembers < ActiveRecord::Migration
  def self.up
    add_column :potential_members, :validation_key, :string
  end

  def self.down
    remove_column :potential_members, :validation_key
  end
end
