class CreatePotentialMembers < ActiveRecord::Migration
  def self.up
    create_table :potential_members do |t|
      t.string :first_name
      t.string :family_name
      t.string :email
    end
  end

  def self.down
    drop_table :potential_members
  end
end
