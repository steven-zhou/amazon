class Relationship < ActiveRecord::Base
  
  belongs_to :source_person, :foreign_key => :source_person_id, :class_name => "Person"
  belongs_to :related_person, :foreign_key => :related_person_id, :class_name => "Person"
  
  belongs_to :relationship_type
    
end
