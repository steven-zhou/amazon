class OrganisationRelationship < ActiveRecord::Base

  belongs_to :source_organisation, :foreign_key => :source_organisation_id, :class_name => "Organisation"
  belongs_to :related_organisation, :foreign_key => :related_organisation_id, :class_name => "Organisation"

  validates_presence_of :related_organisation_id
  validates_uniqueness_of :related_organisation_id, :scope => [:source_organisation_id]
  validate :related_organisation_cannot_be_the_same_as_source_organisation, :organisation_must_be_valid


  before_create :check_existing_organition,:check_organisation_level,:update_branch_level,:set_family_id
  after_destroy :delete_level_and_family_id,:delete_all_relationship

  #  def self.delete_all_relationship(id)
  #    @source_orgs = OrganisationRelationship.find_all_by_source_organisation_id(id)
  #    @relate_orgs = OrganisationRelationship.find_all_by_related_organisation_id(id)
  #
  #    @source_orgs.each do |i|
  #      i.destroy
  #    end
  #
  #    @relate_orgs.each do |i|
  #      i.destroy
  #    end
  #  end

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


  def check_organisation_level
    @organisation = Organisation.find(self.related_organisation_id)
    @temp = true
    if @organisation.level == 0
      errors.add(:check_level,"can't add level 0 organisaion")
      @temp = false
    else
      @temp = true
    end

    if !@organisation.organisation_as_source.blank? || !@organisation.organisation_as_related.blank?
      errors.add(:check_level,"already had organisaion relationship")
      @temp = false
    else
       @temp = true
    end

     return @temp
  end

  def check_existing_organition
    @parent = Organisation.find(self.source_organisation_id)
    @branch = Organisation.find(self.related_organisation_id)
    if @branch.family_id == @parent.family_id
      errors.add(:same_organistion_family,"organisiton already in family")
      return false
    else
      return true
    end
  end

  def delete_all_relationship
    @source_orgs = OrganisationRelationship.find_all_by_source_organisation_id(self.related_organisation_id)
    @relate_orgs = OrganisationRelationship.find_all_by_related_organisation_id(self.related_organisation_id)

    @source_orgs.each do |i|
      i.destroy
    end

    @relate_orgs.each do |i|
      i.destroy
    end
  end

  def delete_level_and_family_id


    @branch = Organisation.find(self.related_organisation_id)
    @branch.level = nil
    @branch.family_id = nil
    @branch.save
  end


end
