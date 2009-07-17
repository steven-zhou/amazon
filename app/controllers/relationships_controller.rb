class RelationshipsController < ApplicationController
  
  def create
    @source_person = Person.find(params[:person_id])
    @relationship = Relationship.new(params[:relationship])
    @relationship.source_person= @source_person
    @related_person = @relationship.related_person
    @person = @source_person
    @relationship.save
    
    respond_to do |format|
      format.js{}
    end
  end
  
  def remove_relation
    @source_person = Person.find(params[:person_id])
    @related_person = Person.find(params[:related_person_id])
    
    @relationship = Relationship.find_by_source_person_id_and_related_person_id(@source_person, @related_person)
    @relationship.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
end
