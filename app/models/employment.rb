class Employment < ActiveRecord::Base
  acts_as_list :column => 'sequence_no'

  belongs_to :employee, :class_name => 'Person', :foreign_key => 'person_id'
  belongs_to :emp_recruiter, :class_name => 'Person', :foreign_key => 'hired_by'
  belongs_to :emp_supervisor, :class_name => 'Person', :foreign_key => 'report_to'
  belongs_to :emp_terminator, :class_name => 'Person', :foreign_key => 'terminated_by'
  belongs_to :emp_suspender, :class_name => 'Person', :foreign_key => 'suspended_by'
  belongs_to :organisation

  validates_presence_of :organisation_id

  after_create :update_priority
  before_destroy :update_priority_before_destroy

  private
  def update_priority
    self.move_to_bottom
  end

  def update_priority_before_destroy
    self.remove_from_list
  end

end
