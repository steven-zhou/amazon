class PersonGroupsController < ApplicationController



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
      render 'show.js' 
    end
     
  end


  def destroy
    #@group_type = Tag.find(params[:id].to_i)
    @person_group = PersonGroup.find(params[:id].to_i)
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

  


      


      respond_to do |format|
      format.js
    end
  end

end
