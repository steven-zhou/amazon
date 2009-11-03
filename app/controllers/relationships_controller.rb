class RelationshipsController < ApplicationController
  
  def create
    #    @source_person = Person.find(params[:person_id].to_i)
    #    @relationship = Relationship.new(params[:relationship])
    #    @relationship.source_person= @source_person
    #    @related_person = @relationship.related_person
    #    @person = @source_person
    #    @relationship.save
    @source_person = Person.find(params[:person_id].to_i)
    @person = @source_person
    @relationship = Relationship.new(params[:relationship])
    if @relationship.save
      flash.now[:message]= "saved successfully"
      @related_person = @relationship.related_person
      @relationship_type = @relationship.relationship_type.name
      if (@relationship_type == 'Father' || @relationship_type == 'Mother')
        @siblings = @source_person.siblings
      elsif (@relationship_type == 'Spouse')
        @relationship_spouse = Relationship.new
        @relationship_spouse.source_person_id = params[:relationship][:related_person_id]
        @relationship_spouse.related_person_id = params[:relationship][:source_person_id]
        @relationship_spouse.relationship_type_id = params[:relationship][:relationship_type_id]
        @relationship_spouse.save
       
      end
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "related_person")if (!@relationship.errors[:related_person_id].nil? && @relationship.errors.on(:related_person_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "related_person")if (!@relationship.errors[:related_person_id].nil? && @relationship.errors.on(:related_person_id).include?("has already been taken"))
      flash.now[:error] = flash_message(:type => "same_person_error", :field => "related_person")if (!@relationship.errors[:related_person_id].nil? && @relationship.errors.on(:related_person_id).include?("can't be same as source person"))
    end

     @relationship_new = Relationship.new
    respond_to do |format|
      format.js{}
    end
  end
  
  def remove_relation
    @source_person = Person.find(params[:person_id].to_i)
    @related_person = Person.find(params[:related_person_id].to_i)
    @person = Person.find(params[:person_id].to_i)
    @relationship = Relationship.find_by_source_person_id_and_related_person_id(@source_person, @related_person)
    if (@relationship.relationship_type.name == 'Spouse')
      @source_person_spouse = Person.find(params[:related_person_id].to_i)
      @related_person_spouse = Person.find(params[:person_id].to_i)
      @relationship_spouse = Relationship.find_by_source_person_id_and_related_person_id(@source_person_spouse, @related_person_spouse)
      @relationship.destroy
      @relationship_spouse.destroy
    else
      @relationship.destroy
    end
   @relationship_new = Relationship.new
    
    respond_to do |format|
      format.js
    end
  end
  
end
