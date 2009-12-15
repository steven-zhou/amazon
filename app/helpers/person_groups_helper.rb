module PersonGroupsHelper
   def format_group(person_group)
    formatted = ""
    formatted += " #{person_group.group_type.tag_type.tag_meta_type.name} -" unless person_group.group_type.blank?
    if person_group.group_type.tag_type.to_be_removed == false  and !person_group.group_type.tag_type.blank?
    formatted += " #{person_group.group_type.tag_type.name} - "
    else
    formatted += "<span class = 'red'> #{person_group.group_type.tag_type.name} </span> - "
    end

    if (!person_group.group_type.tag_type.to_be_removed and !person_group.group_type.tag_type.blank?) and (!person_group.group_type.to_be_removed and !person_group.group_type.blank?)
    formatted += " #{person_group.group_type.name}"
    else
    formatted += " <span class = 'red'>#{person_group.group_type.name}</span> "
    end
    return formatted
  end

end
