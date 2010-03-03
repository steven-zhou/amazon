module AddressesHelper
  
  # Returns the address in a readable format
  def format_address(address)
    formatted = ""
    formatted += "#{address.building_name} <br/>" unless address.building_name.blank?
    formatted += "#{address.suite_unit} " + " / " unless address.suite_unit.blank?
    formatted += "#{address.street_number} " unless address.street_number.blank?
    formatted += "#{address.street_name} <br/>" unless address.street_name.blank?
    formatted += "#{address.town} " unless address.town.blank?
    formatted += "#{address.district} " unless address.district.blank?
    formatted += "#{address.region} <br/>" unless address.region.blank?
    formatted += "#{address.state} " unless address.state.blank?
    formatted += "#{address.postal_code} " unless address.postal_code.blank?
    formatted += "#{address.country.short_name} <br/>" unless ( address.country.nil? || address.country.short_name.blank? )
    return formatted
  end
  
end
