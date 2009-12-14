class OrganisationRelationship < ActiveRecord::Base

    belongs_to :source_organisation, :foreign_key => :source_organisation_id, :class_name => "Organisation"
    belongs_to :related_organisation, :foreign_key => :related_organisation_id, :class_name => "Organisation"

   validates_presence_of :related_organisation_id
   validates_uniqueness_of :related_organisation_id, :scope => [:source_organisation_id]

  validate :related_organisation_cannot_be_the_same_as_source_organisation, :organisation_must_be_valid,:check_lower_level,:add_next_level
  before_create :check_org_relationship
  protected
  def related_organisation_cannot_be_the_same_as_source_organisation
      errors.add(:related_organisation_id, "can't be same as source person") if source_organisation_id == related_organisation_id
  end

  def organisation_must_be_valid
    errors.add(:related_organisation_id, "can't be invalid") if (!related_organisation_id.blank? && Organisation.find_by_id(related_organisation_id).nil?)

  end

 
    def check_lower_level

    errors.add(:related_organisation_id, "can't be invalid") if (Organisation.find_by_id(related_organisation_id).level <= Organisation.find_by_id(source_organisation_id).level )

    end

     def add_next_level

    errors.add(:related_organisation_id, "can't be invalid") if (Organisation.find_by_id(related_organisation_id).level - Organisation.find_by_id(source_organisation_id).level > 1 )

    end

     private
     def check_org_relationship
      @existing_relationship =OrganisationRelationship.find_by_related_organisation_id(self.related_organisation_id)
       @existing_relationship.destroy if !@existing_relationship.nil?
     end


end
