class RoleConditionsController < ApplicationController

  before_filter :check_authentication

  def show_roles
    @role = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)
    respond_to do |format|
      format.js
    end
  end


  def add_conditions

    
    unless params[:add_doctype_id].nil?
      params[:add_doctype_id].each do |doctype_id|
        @role_condition = RoleCondition.new
        @role_condition.role_id = params[:role_id]
        @role_condition.doctype_id = doctype_id

        @role_condition.save
        

      end
    end
    @role = Role.find(params[:role_id])
    respond_to do |format|

      format.js
        
      
    end
  end

  def remove_conditions
      @role = Role.find(params[:role_id])
    unless params[:remove_doctype_id].nil?
      params[:remove_doctype_id].each do |doctype_id|
     
        @role_condition = @role.role_conditions.find(doctype_id)
       
        @role_condition.destroy

      end
    end
   
    respond_to do |format|

      format.js
      
    end

  end

 def create

   @role = Role.new
    respond_to do |format|

      format.js


    end
 end

end
