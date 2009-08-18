Factory.define :employment do |f|
  f.sequence(:id) { |n| n }
  f.staff_reference "Staff reference"
  f.position_reference "Position reference"
  f.position_name "Developer"
  f.commenced_date Date.today()
  f.term_end_date Date.today()
  f.duties_resposibilities "Manage"
  f.weekly_nominal_hours "40"
  f.hourly_rate "20"
  f.plus_package "super"
  f.award_other "None"
  f.suspension_start_date Date.today()
  f.suspension_end_date Date.today()
  f.suspension_reason "Unknown"
  f.suspension_remarks "Unknown"
  f.termination_notice_date Date.today()
  f.termination_date Date.today()
  f.termination_reason "Retire"
  f.termination_remarks "He is happy"

  f.association :employee, :factory => :john
  f.association :emp_recruiter, :factory => :john
  f.association :emp_supervisor, :factory => :john
  f.association :emp_terminator, :factory => :john
  f.association :emp_suspender, :factory => :john
  f.association :organisation, :factory => :google

  f.association :department, :factory => :department
  f.association :section, :factory => :section
  f.association :cost_centre, :factory => :cost_centre
  f.association :position_title, :factory => :position_title
  f.association :position_classification, :factory => :position_classification
  f.association :position_type, :factory => :position_type
  f.association :award_agreement, :factory => :award_agreement
  f.association :position_status, :factory => :position_status
  f.association :payment_frequency, :factory => :payment_frequency
  f.association :payment_method, :factory => :payment_method
  f.association :payment_day, :factory => :payment_day
  f.association :suspension_type, :factory => :suspension_type
  f.association :termination_method, :factory => :termination_method

end