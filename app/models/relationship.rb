class Relationship < ActiveRecord::Base
  
  belongs_to :source_person, :foreign_key => :source_person_id, :class_name => "Person"
  belongs_to :related_person, :foreign_key => :related_person_id, :class_name => "Person"
  
  belongs_to :relationship_type, :class_name => "RelationshipType", :foreign_key => "relationship_type_id"

  validates_presence_of :related_person_id
  validates_uniqueness_of :related_person_id, :scope => [:source_person_id]
  validate :related_person_cannot_be_the_same_as_source_person, :related_person_cannot_be_nil
  
  protected
  def related_person_cannot_be_the_same_as_source_person
      errors.add(:related_person_id, "can't be same as source person") if source_person_id == related_person_id
  end

  def related_person_cannot_be_nil
      error.add(:related_person_id, "can't be nil") if related_person.nil?
  end
end
