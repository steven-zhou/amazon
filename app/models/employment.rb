class Employment < ActiveRecord::Base
  #acts_as_list :column => 'sequence_no'

  belongs_to :employee, :class_name => 'Person', :foreign_key => 'person_id'
  belongs_to :emp_recruiter, :class_name => 'Person', :foreign_key => 'hired_by'
  belongs_to :emp_supervisor, :class_name => 'Person', :foreign_key => 'report_to'
  belongs_to :emp_terminator, :class_name => 'Person', :foreign_key => 'terminated_by'
  belongs_to :emp_suspender, :class_name => 'Person', :foreign_key => 'suspended_by'
  belongs_to :organisation

  validates_presence_of :organisation_id

  before_save :update_priority
  before_destroy :update_priority_before_destroy

  private
  def update_priority
    #self.move_to_bottom
    self.sequence_no = self.employee.employments.length+1 if self.new_record?
  end

  def update_priority_before_destroy
    sequence_no = self.sequence_no
    Employment.transaction do
      self.employee.employments.each { |employment|
        if (employment.sequence_no > sequence_no)
          employment.sequence_no -= 1
          employment.save!
        end
      }
    end
  end

end
