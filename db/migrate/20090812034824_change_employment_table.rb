class ChangeEmploymentTable < ActiveRecord::Migration
  def self.up
      remove_column :employments, :department
      remove_column :employments, :section
      remove_column :employments, :pay_cost_centre
      remove_column :employments, :position_title
      remove_column :employments, :position_classification
      remove_column :employments, :position_type
      remove_column :employments, :award_agreement
      remove_column :employments, :position_status
      remove_column :employments, :payment_frequency
      remove_column :employments, :payment_method
      remove_column :employments, :payment_day
      remove_column :employments, :suspension_type
      remove_column :employments, :termination_method

      add_column :employments, :department_id, :integer
      add_column :employments, :section_id, :integer
      add_column :employments, :cost_centre_id, :integer
      add_column :employments, :position_title_id, :integer
      add_column :employments, :position_classification_id, :integer
      add_column :employments, :position_type_id, :integer
      add_column :employments, :award_agreement_id, :integer
      add_column :employments, :position_status_id, :integer
      add_column :employments, :payment_frequency_id, :integer
      add_column :employments, :payment_method_id, :integer
      add_column :employments, :payment_day_id, :integer
      add_column :employments, :suspension_type_id, :integer
      add_column :employments, :termination_method_id, :integer
  end

  def self.down
      remove_column :employments, :department_id
      remove_column :employments, :section_id
      remove_column :employments, :cost_centre_id
      remove_column :employments, :position_title_id
      remove_column :employments, :position_classification_id
      remove_column :employments, :position_type_id
      remove_column :employments, :award_agreement_id
      remove_column :employments, :position_status_id
      remove_column :employments, :payment_frequency_id
      remove_column :employments, :payment_method_id
      remove_column :employments, :payment_day_id
      remove_column :employments, :suspension_type_id
      remove_column :employments, :termination_method_id

      add_column :employments, :department, :string
      add_column :employments, :section, :string
      add_column :employments, :cost_centre, :string
      add_column :employments, :position_title, :string
      add_column :employments, :position_classification, :string
      add_column :employments, :position_type, :string
      add_column :employments, :award_agreement, :string
      add_column :employments, :position_status, :integer
      add_column :employments, :payment_frequency, :string
      add_column :employments, :payment_method, :string
      add_column :employments, :payment_day, :string
      add_column :employments, :suspension_type, :string
      add_column :employments, :termination_method, :string
  end
end
