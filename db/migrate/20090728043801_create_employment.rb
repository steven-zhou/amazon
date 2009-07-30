class CreateEmployment < ActiveRecord::Migration
  def self.up
    create_table :employments do |t|
      t.column :person_id, :integer
      t.column :organisation_id, :integer
      t.column :sequence_no, :integer
      t.column :staff_reference, :string
      t.column :department, :string
      t.column :section, :string
      t.column :position_reference, :string
      t.column :position_name, :string
      t.column :position_title, :string
      t.column :commenced_date, :date
      t.column :term_length, :float
      t.column :term_end_date, :date
      t.column :position_type, :string
      t.column :position_status, :string
      t.column :position_classification, :string
      t.column :duties_resposibilities, :string
      t.column :hired_by, :integer
      t.column :report_to, :integer
      t.column :weekly_nominal_hours, :float
      t.column :hourly_rate, :float
      t.column :annual_base_salary, :float
      t.column :plus_package, :string
      t.column :pay_cost_centre, :string
      t.column :payment_frequency, :string
      t.column :payment_method, :string
      t.column :payment_day, :string
      t.column :award_agreement, :string
      t.column :award_other, :string
      t.column :suspension_start_date, :date
      t.column :suspension_end_date, :date
      t.column :suspended_by, :integer
      t.column :suspension_type, :string
      t.column :suspension_reason, :string
      t.column :suspension_remarks, :string
      t.column :termination_notice_date, :date
      t.column :termination_date, :date
      t.column :terminated_by, :integer
      t.column :termination_method, :string
      t.column :termination_reason, :string
      t.column :termination_remarks, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :employments
  end
end
