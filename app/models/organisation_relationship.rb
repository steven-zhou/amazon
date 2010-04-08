class OrganisationRelationship < ActiveRecord::Base

  belongs_to :source_organisation, :foreign_key => :source_organisation_id, :class_name => "Organisation"
  belongs_to :related_organisation, :foreign_key => :related_organisation_id, :class_name => "Organisation"

  validates_presence_of :related_organisation_id
  validates_uniqueness_of :related_organisation_id, :scope => [:source_organisation_id]
  validate :related_organisation_cannot_be_the_same_as_source_organisation, :organisation_must_be_valid


  before_create :update_branch_level,:set_family_id
  after_destroy :delete_level_and_family_id

  def self.delete_all_relationship(id)
    @source_orgs = OrganisationRelationship.find_all_by_source_organisation_id(id)
    @relate_orgs = OrganisationRelationship.find_all_by_related_organisation_id(id)

    @source_orgs.each do |i|
      i.destroy
    end

    @relate_orgs.each do |i|
      i.destroy
    end
  end

  protected

  def related_organisation_cannot_be_the_same_as_source_organisation
    errors.add(:related_organisation_id, "can't be same as source organisation") if source_organisation_id == related_organisation_id
  end

  def organisation_must_be_valid
    errors.add(:related_organisation_id, "can't be invalid") if (!related_organisation_id.blank? && Organisation.find_by_id(related_organisation_id).nil?)
  end


  private
  def update_branch_level
    @parent = Organisation.find(self.source_organisation_id)
    @branch = Organisation.find(self.related_organisation_id)
    @branch.update_attribute("level", @parent.level+1)
  end

  def set_family_id
    @parent = Organisation.find(self.source_organisation_id)
    @branch = Organisation.find(self.related_organisation_id)
    @branch.update_attribute("family_id", @parent.family_id)
  end


  def delete_level_and_family_id

  @organisation = Organisation.find(self.related_organisation_id)
  @organisation.level = nil
  @organisation.family_id = nil
  @organisation.save
  end
end
