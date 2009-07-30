module RolesHelper

   def unselected_role_options(person)
    options = ""
    keywords = Role.all - person.roles
    keywords.each do |role|
      options = options + "<option value='#{role.id}' class='#{role.role_type_name}'>#{role.name}</option>"
    end
    return options
  end

   def   get_roletype
        RoleType.find(:all).collect{|item|[item.name,item.id]}.insert(0,["please choose",nil])
   end

end
