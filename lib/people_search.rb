module PeopleSearch
  
  def self.by_name(params)
    
    equality = ['id', 'custom_id', 'primary_title_id', 'second_title_id', 'gender_id', 'religion_id',
      'origin_country_id', 'residence_country_id', 'nationality_id', 'other_nationality_id',
      'language_id', 'other_language_id', 'birth_date', 'industry_sector_id', 'onrecord_since', 'marital_status_id']
    like = ['first_name', 'family_name', 'maiden_name', 'middle_name', 'initials',
      'preferred_name', 'post_title', 'interests', 'primary_salutation', 'second_salutation']

    params.delete_if {|key, value| value == "" } 
    condition_clauses = Array.new
    condition_options = Array.new
    
    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("people.#{attribute} = ?")
        condition_options.push(value)
      when 'like'
        condition_clauses.push("people.#{attribute} LIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end    
    end

    query = condition_clauses.join(' AND '), *condition_options

    Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options])
    
  end

  def self.by_phone(params)
    equality = ['contact_type_id']
    like = ['phone_pre_value', 'phone_value', 'phone_post_value']
    params.delete_if {|key, value| value == "" }
    condition_clauses = Array.new
    condition_options = Array.new

    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("phones.#{attribute} = ?")
        condition_options.push(value)
      when 'like'
        condition_clauses.push("phones.#{attribute} LIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:phones])
  end

  def self.by_email(params)
    equality = ['contact_type_id']
    like = ['email_address']
    params.delete_if {|key, value| value == "" }
    condition_clauses = Array.new
    condition_options = Array.new

    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("emails.#{attribute} = ?")
        condition_options.push(value)
      when 'like'
        condition_clauses.push("emails.#{attribute} LIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:emails])
  end
  
  def self.by_note(params)
    equality = ['note_type_id']
    like = ['note_label', 'note_short_description']
    params.delete_if {|key, value| value == "" }
    condition_clauses = Array.new
    condition_options = Array.new

    params.each do |attribute,value|
      case sql_condition(attribute, equality, like)
      when 'equality'
        condition_clauses.push("notes.#{attribute} = ?")
        condition_options.push(value)
      when 'like'
        condition_clauses.push("notes.#{attribute} LIKE ?")
        condition_options.push(value + '%')
      else
        raise InvalidAttribute, 'Attribute must be in array', caller
      end
    end

    Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:notes])
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

    Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:addresses])
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

    Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:keywords])
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
