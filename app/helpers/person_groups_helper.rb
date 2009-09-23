module PersonGroupsHelper
   def format_group(person_group)
    formatted = ""
    formatted += " #{person_group.group_type.tag_type.tag_meta_type.name} -" unless person_group.group_type.blank?
    formatted += " #{person_group.group_type.tag_type.name} - " unless person_group.group_type.tag_type.blank?
    formatted += " #{person_group.group_type.name}" unless person_group.group_type.tag_type.tag_meta_type.blank?
    return formatted
  end

end
