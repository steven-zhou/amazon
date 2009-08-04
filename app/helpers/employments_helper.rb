module EmploymentsHelper
  # Returns the employment in a readable format
  def format_employment(employment)
    formatted = ""
    formatted += "Organisation: #{employment.organisation.full_name} <br/>" unless employment.organisation.blank?
    formatted += "Department: #{employment.department} <br/>" unless employment.department.blank?
    formatted += "Position Title: #{employment.position_title} " unless employment.position_title.blank?
    return formatted
  end
end
