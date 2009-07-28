Factory.define :employment do |f|
  f.staff_reference "Staff reference"
  f.department "S&D"
  f.section "Software"
  f.position_reference "Position reference"
  f.position_name "Developer"
  f.position_title "Junior"
  f.commenced_date Date.today()
  f.term_length "365"
  f.term_end_date Date.today()
  f.position_type "Permanent"
  f.position_status "Full-time"
  f.position_classification "Management"
  f.duties_resposibilities "Manage"
  f.nominal_hours "40"
  f.base_salary "20"
  f.plus_package "super"
  f.pay_cost_centre "Unknown"
  f.payment_frequency "Monthly"
  f.payment_method "Bank transfer"
  f.payment_date "every 15th of the month"
  f.award_agreement "Unknown"
  f.award_other "None"
  f.termination_notice_date Date.today()
  f.termination_method "By notice"
  f.termination_reason "Retire"
  f.remarks "He is happy"

  f.association :employee, :factory => :john
  f.association :recruiter, :factory => :john
  f.association :supervisor, :factory => :john
  f.association :terminator, :factory => :john
  f.association :organisation, :factory => :google

end