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
  belongs_to :payroll_method
  belongs_to :payment_day
  belongs_to :suspension_type
  belongs_to :termination_method

  validates_presence_of :organisation, :commenced_date, :emp_recruiter,:staff_reference,:position_name
  validates_associated :organisation, :emp_supervisor
  validates_numericality_of :weekly_nominal_hours, :hourly_rate, :greater_than_or_equal_to => 0
  validate :end_date_must_be_equal_or_after_commence_date, :person_must_be_valid

  before_create :assign_priority
  before_save :calculate_salary, :update_priority

  protected
  def end_date_must_be_equal_or_after_commence_date
    errors.add(:commenced_date, "can't be blank") if (commenced_date.nil? )
    errors.add(:term_end_date, "can't be before commence date") if (!term_end_date.nil? && !commenced_date.nil? && term_end_date < commenced_date)
    errors.add(:suspension_end_date, "can't be before suspension start date") if (!suspension_end_date.nil? && !suspension_start_date.nil? && suspension_end_date < suspension_start_date)
    errors.add(:termination_date, "can't be before termination_notice_date") if (!termination_date.nil? && !termination_notice_date.nil? && termination_date < termination_notice_date)
  end

  def person_must_be_valid
    
    errors.add(:report_to, "can't be invalid") if (!report_to.blank? && Person.find_by_id(report_to).nil?)
    errors.add(:terminated_by, "can't be invalid") if (!terminated_by.blank? && Person.find_by_id(terminated_by).nil?)
    errors.add(:suspended_by, "can't be invalid") if (!suspended_by.blank? && Person.find_by_id(suspended_by).nil?)
  end
  

  private
  def assign_priority
    self.sequence_no = self.employee.employments.length+1
  end

  def update_priority
    sequence_no = self.sequence_no
    if (self.status == false)
    
      Employment.transaction do
        Employment.without_callbacks(:before_save) do
          self.employee.employments.each { |employment|
            if (employment.sequence_no > sequence_no)
              employment.sequence_no -= 1
              employment.save
            end
          }
        end        
      end

      self.sequence_no = self.employee.employments.length
    end

    
  end

  def calculate_salary
    self.annual_base_salary = self.weekly_nominal_hours * self.hourly_rate * 52
  end

end
