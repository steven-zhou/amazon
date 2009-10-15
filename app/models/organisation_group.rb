class OrganisationGroup < ActiveRecord::Base


 validates_uniqueness_of :tag_id, :scope => :organisation_id
 validates_presence_of :tag_id, :organisation_id

 belongs_to :group_owner, :class_name => 'Organisation', :foreign_key => 'organisation_id'
 belongs_to :group_type,  :class_name => 'Tag', :foreign_key => 'tag_id'

end
