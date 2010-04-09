class OrganisationRelationship < ActiveRecord::Base

  belongs_to :source_organisation, :foreign_key => :source_organisation_id, :class_name => "Organisation"
  belongs_to :related_organisation, :foreign_key => :related_organisation_id, :class_name => "Organisation"

  validates_presence_of :related_organisation_id
  validates_uniqueness_of :related_organisation_id, :scope => [:source_organisation_id]
  validate :check_organisation_level, :organisation_must_be_valid


  before_create :update_branch_level_and_set_family_id
  after_destroy :delete_level_and_family_id,:delete_all_relationship

  protected

  def check_organisation_level
    errors.add(:check_level, "already had organisaion relationship") if Organisation.find(related_organisation_id).level != nil
  end

  def organisation_must_be_valid
    errors.add(:related_organisation_id, "can't be invalid") if (!related_organisation_id.blank? && Organisation.find_by_id(related_organisation_id).nil?)
  end


  private
  def update_branch_level_and_set_family_id
    @parent = Organisation.find(self.source_organisation_id)
    @branch = Organisation.find(self.related_organisation_id)
    @branch.update_attribute("level", @parent.level+1)
    @branch.update_attribute("family_id", @parent.family_id)
  end


  def delete_level_and_family_id
    @branch = Organisation.find(self.related_organisation_id)
    @branch.level = nil
    @branch.family_id = nil
    @branch.save
  end

  
  def delete_all_relationship
    #to find all the related and source organisation relationship
    @source_organisation = OrganisationRelationship.find_all_by_source_organisation_id(self.related_organisation_id)
    @relate_organisation = OrganisationRelationship.find_all_by_related_organisation_id(self.related_organisation_id)


    @source_organisation.each do |i|
      i.destroy
    end

    @relate_organisation.each do |i|
      i.destroy
    end

  end


end
