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

   def create
    @person = Person.find(params[:person_id])
    @role = @person.roles.new(params[:role])

    @role.save
    respond_to do |format|
      format.js
    end
  end

  def show
    @role = Role.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    respond_to do |format|
      format.js
    end
  end

  def edit
    @role = Role.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role]["#{@role.id}"])
      respond_to do |format|
        format.js
      end
    end
  end
  
  def get_roles
  puts "DEBUG--#{params[:role_type_id]}"


    @role = Role.find_by_role_type_id(params[:role_type_id]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)

   # puts "DEBUG ** #{@roles.to_yaml}"
   
    respond_to do |format|
        format.js
      end
  end

   def select_with_ajax
    @roles = [["please select",""]]+Role.find(:all, :conditions => ["role_type_id = ?", params[:role_type_id]]).collect { |item| [item.name, item.id] }
     render(:layout => false)
   end


end
