class OrganisationGroup < ActiveRecord::Base


 validates_uniqueness_of :tag_id, :scope => :organisation_id
 validates_presence_of :tag_id, :organisation_id

 belongs_to :group_owner, :class_name => 'Organisation', :foreign_key => 'organisation_id'
 belongs_to :group_type,  :class_name => 'Tag', :foreign_key => 'tag_id'
   def self.find_org_group(id,group_id)
    OrganisationGroup.find(:first,:conditions=>["organisation_id = ? and tag_id = ?",id,group_id])
  end

       def self.find_all_org_group(id,group_id)
    OrganisationGroup.find(:all,:conditions=>["organisation_id = ? and tag_id = ?",id,group_id])
  end

end
