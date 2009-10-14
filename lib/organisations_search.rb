module OrganisationsSearch
  
  def self.by_name(params)
    
    equality = ['id', 'custom_id', 'registered_date', 'registered_country_id', 'number_of_full_time_employees', 'number_of_part_time_employees',
      'number_of_contractors', 'number_of_volunteers', 'number_of_other_workers', 'organisation_hierarchy_id',
      'organisation_type_id', 'business_type_id', 'industry_sector_id', 'business_category_id', 'onrecord_since']
    like = ['full_name', 'short_name', 'trading_as', 'registered_name', 'registered_number',
      'tax_file_no', 'legal_no_1', 'legal_no_2', 'industrial_code', 'business_mission', 'remarks']

    params.delete_if {|key, value| value == "" } 
    condition_clauses = Array.new
    condition_options = Array.new
    
    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("organisations.#{attribute} = ?")
        condition_options.push(value)
      when 'like'
        condition_clauses.push("organisations.#{attribute} LIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end    
    end

    query = condition_clauses.join(' AND '), *condition_options

    Organisation.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options])
    
  end

  def self.by_phone(params)
    equality = ['contact_meta_type_id']
    like = ['pre_value', 'value', 'post_value']
    params.delete_if {|key, value| value == "" }
    condition_clauses = Array.new
    condition_options = Array.new

    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("contacts.#{attribute} = ?")
        condition_options.push(value)
      when 'like'
        condition_clauses.push("contacts.#{attribute} LIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    Organisation.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:phones])
  end

  def self.by_email(params)
    equality = ['contact_meta_type_id']
    like = ['value']
    params.delete_if {|key, value| value == "" }
    condition_clauses = Array.new
    condition_options = Array.new

    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("contacts.#{attribute} = ?")
        condition_options.push(value)
      when 'like'
        condition_clauses.push("contacts.#{attribute} LIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    Organisation.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:emails])
  end

  
  def self.by_address(params)
    equality = ['country_id', 'address_type_id']
    like = ['building_name', 'suite_unit', 'street_number', 'street_name', 'town', 'district', 'region', 'state', 'postal_code']
    params.delete_if {|key, value| value == "" }
    condition_clauses = Array.new
    condition_options = Array.new

    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("addresses.#{attribute} = ?")
        condition_options.push(value)
      when 'like'
        condition_clauses.push("addresses.#{attribute} LIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    Organisation.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:addresses])
  end
  
  def self.by_keyword(params)
    equality = ['keyword_id']
    params.delete_if {|key, value| value == "" }
    condition_clauses = Array.new
    condition_options = Array.new

    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("keywords.#{attribute} = ?")
        condition_options.push(value)
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    Organisation.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:keywords])
  end

  private
  
  def self.sql_condition(attribute, equality_array, like_array)
    if equality_array.include?(attribute)
      return "equality"
    elsif like_array.include?(attribute)
      return 'like'
    end 
  end
  
end
