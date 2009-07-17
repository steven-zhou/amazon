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

    Person.find(:all, :conditions => [condition_clauses.join(' AND '), *condition_options], :include => [:phones,:addresses,:contacts])
    
  end

  def self.by_phone(phone_attributes)
    Person.with_phone(phone_attributes[:value])
  end
  
  def self.by_email(email_attributes)
    Person.with_email(email_attributes[:value])
  end
  
  def self.by_address
    
  end
  
  def self.by_keyword(keyword_attributes)
    @people = Person.with_keyword(keyword_attributes[:id])
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
