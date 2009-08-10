class RolesController < ApplicationController

  
  def get_roles

   @person_role = PersonRole.find(params[:person_role_id]) rescue @person_role = PersonRole.new
   @role = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)

    respond_to do |format|
        format.js
      end
  end

 


end
