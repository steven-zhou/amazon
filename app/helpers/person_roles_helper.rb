module PersonRolesHelper
  def format_role(person_role)
    formatted = ""   
    formatted += "Role: #{person_role.role.name}<br/> " unless person_role.role.blank?
    formatted += "Approved_by: #{person_role.role_approver} <br/>" unless person_role.role_approver.blank?
    formatted += "Assigned_by: #{person_role.role_assigner.name} <br/>" unless person_role.role_assigner.blank?
    return formatted


    
  end




end
