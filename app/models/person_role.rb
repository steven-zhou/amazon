class PersonRole < ActiveRecord::Base
  acts_as_list :column => 'sequence_no'
  belongs_to :role_player, :class_name => 'Person', :foreign_key => 'person_id'
  belongs_to :role_assigner, :class_name => 'Person', :foreign_key => 'assigned_by'
  belongs_to :role_approver, :class_name => 'Person', :foreign_key => 'approved_by'
  belongs_to :role_superviser, :class_name => 'Person', :foreign_key => 'supervised_by'
  belongs_to :role_manager, :class_name => 'Person', :foreign_key => 'managed_by'

  belongs_to :role

  validates_presence_of :role_id
  validates_presence_of :person_id

end
