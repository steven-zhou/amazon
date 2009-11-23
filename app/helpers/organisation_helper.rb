module OrganisationHelper

  def format_legal_details(org)
    incorporation = org.country.short_name rescue incorporation = "None Assign"

    formatted = ""
    formatted += "Registered Number: #{org.registered_number} <br/>" unless org.registered_number.blank?
    formatted += "Registered Name: #{org.registered_name} <br/>" unless org.registered_name.blank?
    formatted += "Registered Date: #{org.registered_date} <br/>" unless org.registered_date.blank?
    formatted += "Country of Incorporation: #{incorporation} <br/>" unless incorporation.blank?
      formatted += "Organisation Legal Type: #{org.organisation_type.name} <br/>" unless org.organisation_type.blank?

    formatted += "Tax File Number: #{org.tax_file_no} <br/>" unless org.tax_file_no.blank?
    formatted += "Legal Number 1: #{org.legal_no_1} <br/>" unless org.legal_no_1.blank?
    formatted += "Legal Number 2: #{org.legal_no_2} <br/>" unless org.legal_no_2.blank?
    return formatted
  end

  def format_business_details(org)

    formatted = ""
    formatted += "Industrial Sector: #{org.industry_sector.name} <br/>" unless org.industry_sector.blank?
    formatted += "Industrial Code: #{org.industrial_code} <br/>" unless org.industrial_code.blank?
    formatted += "Business Category: #{org.business_category.name} <br/>" unless org.business_category.blank?
    formatted += "Business Sub Category: #{org.business_sub_category} <br/>" unless org.business_sub_category.blank?

    formatted += "Full Time Employees: #{org.number_of_full_time_employees} <br/>" unless org.number_of_full_time_employees.blank?
    formatted += "Part Time Employees: #{org.number_of_part_time_employees} <br/>" unless org.number_of_part_time_employees.blank?
    formatted += "Contractors: #{org.number_of_contractors} <br/>" unless org.number_of_contractors.blank?
    formatted += "Volunteers: #{org.number_of_volunteers} <br/>" unless org.number_of_volunteers.blank?
    formatted += "Other Workers: #{org.number_of_other_workers} <br/>" unless org.number_of_other_workers.blank?
    formatted += "Remarks: #{org.remarks} <br/>" unless org.remarks.blank?
    return formatted
  end




end
