module EmploymentsHelper
  # Returns the employment in a readable format
  def format_employment(employment)
    formatted = ""
    formatted += "Organisation: #{employment.organisation.full_name} <br/>" unless employment.organisation.blank?
    if !employment.department_id.blank? and Department.find(employment.department_id).to_be_removed == false
    formatted += "Department: #{employment.department.name} <br/>" unless employment.department_id.blank?
    else
    formatted += "Department: <span class = 'red'> #{employment.department.name} </span> <br/>" unless employment.department_id.blank?
    end
    formatted += "Position Title: #{employment.position_title.name} " unless employment.position_title_id.blank?
    return formatted
  end

 
end
