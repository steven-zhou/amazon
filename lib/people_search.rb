module PeopleSearch
  
  def self.by_name(params)
    
    equality = ['id', 'custom_id', 'primary_title_id', 'second_title_id', 'gender_id', 'religion_id',
      'origin_country_id', 'residence_country_id', 'nationality_id', 'other_nationality_id',
      'language_id', 'other_language_id', 'birth_date', 'industry_sector_id', 'onrecord_since', 'marital_status_id','age']
    like = ['first_name', 'family_name', 'maiden_name', 'middle_name', 'initials',
      'preferred_name', 'post_title', 'interests', 'primary_salutation', 'second_salutation']
   

    params.delete_if {|key, value| value == "" } 
    condition_clauses = Array.new
    condition_options = Array.new
    
    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        if attribute == 'age'
          condition_clauses.push("people.birth_date >= ?")
          condition_clauses.push("people.birth_date <= ?")
          condition_options.push(value+'-01-01')
          condition_options.push(value+'-12-31')
        elsif attribute == 'onrecord_since'
          condition_clauses.push("people.onrecord_since >= ?")
          condition_options.push(value.to_date)
        elsif attribute == 'birth_date'
          condition_clauses.push("people.#{attribute} = ?")
          condition_options.push(value.to_date)
        else
          condition_clauses.push("people.#{attribute} = ?")
          condition_options.push(value)
        end
      when 'like'
        condition_clauses.push("people.#{attribute} ILIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end    
    end

    query = condition_clauses.join(' AND '), *condition_options
    return Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :order => "id")
  end

  def self.by_phone(params)
    equality = ['contact_meta_type_id']
    like = ['post_value', 'pre_value', 'value']
    params.delete_if {|key, value| value == "" }
    condition_clauses = Array.new
    condition_options = Array.new

    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("contacts.#{attribute} = ?")
        condition_options.push(value)
      when 'like'
        condition_clauses.push("contacts.#{attribute} ILIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    return Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:phones], :order => "id")

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
        condition_clauses.push("contacts.#{attribute} ILIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    return Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:emails], :order => "id")

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
        condition_clauses.push("addresses.#{attribute} ILIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    return Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:addresses], :order => "id")

  end

  def self.by_keyword(params)
    equality = ['id', 'keyword_type_id']
    like = []
    params.delete_if {|key, value| value == "" }
    condition_clauses = Array.new
    condition_options = Array.new

    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("keywords.#{attribute} = ?")
        condition_options.push(value)
      when 'like'
        condition_clauses.push("keywords.#{attribute} ILIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    return Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:keywords], :order => "id")

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
