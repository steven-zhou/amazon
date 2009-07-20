module PeopleSearch
  
  def self.by_name(params)
    
    equality = ['id', 'custom_id', 'title_id', 'second_title_id', 'gender', 'religion_id', 
      'origin_country_id', 'residence_country_id', 'nationality_id', 'other_nationality_id',
      'language_id', 'other_language_id']
    like = ['first_name', 'family_name', 'maiden_name', 'middle_name', 'initials',
      'preferred_name', 'post_title', 'industry_sector', 'interests']

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

    Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options])
    
  end

  def self.by_phone(phone_type, phone_pre_value, phone_value, phone_post_value)
    #    puts "DEBUG #{phone_attributes.to_yaml}"
    phone_type = !phone_type.empty? ? phone_type : "%"
    #    Person.with_phone(phone_attributes[:pre_value], phone_attributes[:value], phone_attributes[:post_value])
    Person.with_phone(phone_type, phone_pre_value, phone_value, phone_post_value)
  end
  
  def self.by_email(email_type, email_address)
    email_type = !email_type.empty? ? email_type : "%"
    Person.with_email(email_type, email_address)
  end

  def self.by_note(note_type, note_label, note_short_description)

  note_type = !note_type.empty? ? note_type : "%"
    Person.with_note(note_type, note_label, note_short_description)
  end
  
  def self.by_address(params)
    equality = ['country_id', 'address_type_id']
    like = ['building_name', 'suite_unit', 'street_number', 'street_name', 'town',
      'district', 'region', 'state', 'postal_code']
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
  
  def self.by_keyword(keyword_id)
    keyword_id = !keyword_id.empty? ? keyword_id : "%"
    Person.with_keyword(keyword_id)
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
