class RolesController < ApplicationController
 # def show
 # end

  #def create
    #@person = Person.find(params[:person_id])
   # @person.roles << @role = Role.find(params[:role][:id])
   # respond_to do |format|
    #  format.js
   # end
 # end

#  def destroy
#    @person = Person.find(params[:person_id])
 #   @person.roles.delete(@role = Role.find(params[:id]))
 # end

  
  # def select_with_ajax
  #   @role = [["please choose",""]]+Role.find(:all, :conditions => ["fatherid = ?", params[:parent_id]]).collect { |item| [item.name, item.id] }
   #  render(:layout => false)
   #end

  
  
  def get_roles

   @person_role = PersonRole.find(params[:person_role_id]) rescue @person_role = PersonRole.new
   @role = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)

    respond_to do |format|
        format.js
      end
  end

 


end
