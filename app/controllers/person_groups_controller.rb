class PersonGroupsController < ApplicationController
  # System Logging added


  def show
    @person_group = PersonGroup.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create
    
    @person = Person.find(params[:person_id].to_i)
    @group = Tag.find(params[:person_group_id].to_i) rescue @group = Tag.new

    #      if (PersonGroup.find(:all, :conditions => ['people_id = ? AND tag_id = ?', @person.id, @group.id]))
    #        @person_group=PersonGroup.find(:all, :conditions => ['people_id = ? AND tag_id = ?', @person.id, @group.id]);
    #      else
    @person_group = PersonGroup.new
    #       end
    @person_group.people_id= @person.id
    @person_group.tag_id = @group.id
    @person_group.save!
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) created Person Group #{@person_group.id}.")
    #      else
    #        @person_group.update_attributes(params[:person_group])
    #      end

    respond_to do |format|
      format.js
    end
     
  end


  def edit

    @person_group = PersonGroup.find(params[:id])
    @person_group_type = @person_group.group_type
    @person_group_meta_type= @person_group_type.tag_type
    @person_group_meta_meta_type =  @person_group_meta_type.tag_meta_type

    respond_to do |format|
      format.js
    end
  end

  def update

    @person_group= PersonGroup.find(params[:id])
   
    if @person_group.update_attributes(params[:person_group])
      system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) updated Person Group #{@person_group.id}.")
      render 'show.js' 
    end
     
  end


  def destroy
    #@group_type = Tag.find(params[:id].to_i)
    @person_group = PersonGroup.find(params[:id].to_i)
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) deleted #{@person_group.id}.")
    @person_group.destroy
    #@group_type.group_type.destroy
    respond_to do |format|
      format.js
    end
  end


  def show_group_members

    @person_group = PersonGroup.find(params[:person_group_id].to_i)
    @group_members = PersonGroup.find(:all, :conditions => ["tag_id = ?", @person_group.tag_id])

    @group_members.delete_if{|x| x.people_id == @person_group.people_id }

  
    #clear temple table and save result into temple table
    ShowOtherGroupMemberGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @group_members.each do |group_members|
      @sogm = ShowOtherGroupMemberGrid.new #show other group memebers
      @sogm.login_account_id = session[:user]
      @sogm.grid_object_id = group_members.group_owner.id
      @sogm.field_1 = group_members.group_owner.name
#      @sogm.field_2 = group_members.family_name
     
      @sogm.field_2 = group_members.group_owner.primary_phone.value unless group_members.group_owner.primary_phone.blank?
      @sogm.field_3 = group_members.group_owner.primary_address.first_line unless group_members.group_owner.primary_address.blank?
      @sogm.field_4 = group_members.group_owner.primary_email.address unless group_members.group_owner.primary_email.blank?
      @sogm.save
    end


      


    respond_to do |format|
      format.js
    end
  end

end
