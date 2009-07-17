class CreatePersonRoles < ActiveRecord::Migration
  def self.up
    create_table :person_roles do |t|
      t.integer :person_id
      t.integer :role_id
      t.string :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :person_roles
  end
end
