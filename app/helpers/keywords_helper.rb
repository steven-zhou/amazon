module KeywordsHelper
  
  #Returns the person's keywords as options 
  def selected_keyword_options(person)
    keywords = person.keywords
    #options_for_select keywords.collect{|keyword| [keyword.name, keyword.id]}
    options = ""
    keywords.each do |keyword|
      if keyword.to_be_removed == false
      options = options + "<option value='#{keyword.id}' class='#{keyword.keyword_type_name}' remark='#{h keyword.description}'>#{keyword.name}</option>"
      else
      options = options + "<option value='#{keyword.id}' class='#{keyword.keyword_type_name} red' remark='#{h keyword.description}'>#{keyword.name}</option>"
      end
    end
    return options
  end

  #Returns keywords not belonging to a user as options
  def unselected_keyword_options(person)
    options = ""
#    keywords = Keyword.find(:all, :conditions => ["status =true AND to_be_removed = false"]) - person.keywords
    keywords = Keyword.active_record - person.keywords
    keywords.each do |keyword|
      options = options + "<option value='#{keyword.id}' class='#{keyword.keyword_type_name}' remark='#{h keyword.description}'>#{keyword.name}</option>"
    end
    return options
  end

   # Returns the address in a readable format
  def format_keyword(keyword)
    formatted = ""
    formatted += "#{keyword.name} <br/>" unless keyword.name.blank?
    formatted += "#{keyword.description} " unless keyword.description.blank?
   

#    formatted += "#{address.third_line} <br/>" unless address.third_line.blank?
    return formatted
  end
end
