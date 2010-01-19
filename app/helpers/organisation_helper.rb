module OrganisationHelper

  def format_legal_details(org)
    
    formatted = ""
    formatted += "Registered Number: #{org.registered_number} <br/>" unless org.registered_number.blank?
    formatted += "Registered Name: #{org.registered_name} <br/>" unless org.registered_name.blank?
    formatted += "Registered Date: #{org.registered_date} <br/>" unless org.registered_date.blank?
    formatted += "Country of Incorporation: #{org.registered_country.short_name} <br/>" unless org.registered_country.blank?
    if !org.organisation_type.blank? and org.organisation_type.to_be_removed == false
      formatted += "Organisation Legal Type:  #{org.organisation_type.name} <br/>" unless org.organisation_type.blank?
    else
      formatted += "Organisation Legal Type: <span class = 'red'> #{org.organisation_type.name} </span> <br/>" unless org.organisation_type.blank?
    end

    formatted += "Tax File Number: #{org.tax_file_no} <br/>" unless org.tax_file_no.blank?
    formatted += "Legal Number 1: #{org.legal_no_1} <br/>" unless org.legal_no_1.blank?
    formatted += "Legal Number 2: #{org.legal_no_2} <br/>" unless org.legal_no_2.blank?
    return formatted
  end

  def format_business_details(org)

    formatted = ""
    if !org.industry_sector.blank? and org.industry_sector.to_be_removed == false
      formatted += "Industrial Sector: #{org.industry_sector.name} <br/>" unless org.industry_sector.blank?
    else
      formatted += "Industrial Sector:<span class = 'red'> #{org.industry_sector.name} </span><br/>" unless org.industry_sector.blank?
    end
    formatted += "Industrial Code: #{org.industrial_code} <br/>" unless org.industrial_code.blank?
    if !org.business_category.blank? and org.business_category.to_be_removed == false
      formatted += "Business Category: #{org.business_category.name} <br/>" unless org.business_category.blank?
    else
      formatted += "Business Category: <span class = 'red'> #{org.business_category.name} </span>  <br/>" unless org.business_category.blank?
    end

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
