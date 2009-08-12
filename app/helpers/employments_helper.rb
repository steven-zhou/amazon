module EmploymentsHelper
  # Returns the employment in a readable format
  def format_employment(employment)
    formatted = ""
    formatted += "Organisation: #{employment.organisation.full_name} <br/>" unless employment.organisation.blank?
    formatted += "Department: #{employment.department.name} <br/>" unless employment.department_id.blank?
    formatted += "Position Title: #{employment.position_title.name} " unless employment.position_title_id.blank?
    return formatted
  end
end
