class ChangePersonrole < ActiveRecord::Migration
    def self.up
    add_column :person_roles, :sequence_no, :integer
    add_column :person_roles, :assigned_by, :integer
    add_column :person_roles, :approved_by, :integer
    add_column :person_roles, :assignment_date, :date
    add_column :person_roles, :start_date, :date
    add_column :person_roles, :end_date, :date
  end

  def self.down
    remove_column :person_roles, :sequence_no
    remove_column :person_roles, :assigned_by
    remove_column :person_roles, :approved_by
    remove_column :person_roles, :assignment_date
    remove_column :person_roles, :start_date
    remove_column :person_roles, :end_date

  end
end
