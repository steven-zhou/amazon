class Employment < ActiveRecord::Base
  #acts_as_list :column => 'sequence_no'

  belongs_to :employee, :class_name => 'Person', :foreign_key => 'person_id'
  belongs_to :emp_recruiter, :class_name => 'Person', :foreign_key => 'hired_by'
  belongs_to :emp_supervisor, :class_name => 'Person', :foreign_key => 'report_to'
  belongs_to :emp_terminator, :class_name => 'Person', :foreign_key => 'terminated_by'
  belongs_to :emp_suspender, :class_name => 'Person', :foreign_key => 'suspended_by'
  belongs_to :organisation
  belongs_to :department
  belongs_to :section
  belongs_to :cost_centre
  belongs_to :position_title
  belongs_to :position_classification
  belongs_to :position_type
  belongs_to :award_agreement
  belongs_to :position_status
  belongs_to :payment_frequency
  belongs_to :payment_method
  belongs_to :payment_day
  belongs_to :suspension_type
  belongs_to :termination_method

  validates_presence_of :organisation, :commenced_date, :emp_recruiter
  validates_associated :organisation, :emp_supervisor
  validates_numericality_of :weekly_nominal_hours, :hourly_rate
  validate :end_date_must_be_equal_or_after_commence_date, :person_must_be_valid

  before_create :update_priority
  before_save :calculate_salary
  before_destroy :update_priority_before_destroy

  protected
  def end_date_must_be_equal_or_after_commence_date
      errors.add(:term_end_date, "can't be before commence date") if (!term_end_date.nil? && term_end_date < commenced_date)
      errors.add(:suspension_end_date, "can't be before suspension start date") if (!suspension_end_date.nil? && suspension_end_date < suspension_start_date)
      errors.add(:termination_date, "can't be before termination_notice_date") if (!termination_date.nil? && termination_date < termination_notice_date)
  end

  def person_must_be_valid
    #puts "** DEBUG ** report_to = #{report_to}"
    #puts "** DEBUG ** report_to = #{self.to_yaml}"
    #puts "** DEBUG ** supervisor = #{emp_supervisor.to_yaml}"
    errors.add(:emp_supervisor, "can't be invalid") if (!report_to.blank? && emp_supervisor.nil?) 
  end
  

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

  def calculate_salary
    self.annual_base_salary = self.weekly_nominal_hours * self.hourly_rate * 52
  end

end
