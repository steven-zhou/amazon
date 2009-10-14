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
      #@relationship_type = String.new
      @relationship_type = @relationship.relationship_type.name
      # @siblings = Array.new
      if (@relationship_type == 'Father' || @relationship_type == 'Mother')
        #@siblings = @related_person.source_people.of_type('Father').concat(@related_person.source_people.of_type('Mother')).uniq
        @siblings = @source_person.siblings
      end
    else
      flash.now[:error] = flash_message(:type => "field_missing", :field => "related_person")if (!@relationship.errors[:related_person_id].nil? && @relationship.errors.on(:related_person_id).include?("can't be blank"))
      flash.now[:error] = flash_message(:type => "uniqueness_error", :field => "related_person")if (!@relationship.errors[:related_person_id].nil? && @relationship.errors.on(:related_person_id).include?("has already been taken"))
      flash.now[:error] = flash_message(:type => "same_person_error", :field => "related_person")if (!@relationship.errors[:related_person_id].nil? && @relationship.errors.on(:related_person_id).include?("can't be same as source person"))
    end

    
    respond_to do |format|
      format.js{}
    end
  end
  
  def remove_relation
    @source_person = Person.find(params[:person_id].to_i)
    @related_person = Person.find(params[:related_person_id].to_i)
    
    @relationship = Relationship.find_by_source_person_id_and_related_person_id(@source_person, @related_person)
    @relationship.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
end
