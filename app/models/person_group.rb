class PersonGroup < ActiveRecord::Base


 validates_uniqueness_of :tag_id, :scope => :people_id
 validates_presence_of :tag_id, :people_id

  belongs_to :group_owner, :class_name => 'Person', :foreign_key => 'people_id'

  belongs_to :group_type,  :class_name => 'Tag', :foreign_key => 'tag_id'





  def self.find_person_group(id,group_id)
    PersonGroup.find(:first,:conditions=>["people_id = ? and tag_id = ?",id,group_id])
  end

    def self.find_all_person_group(id,group_id)
    PersonGroup.find(:all,:conditions=>["people_id = ? and tag_id = ?",id,group_id])
  end
#  validate :group_must_unique
#
#
# def group_must_unique
#   errors.add(:person_group_id, "A group already exists with the same name.") if (people_id == PersonGroup.find(people_id).people_id && tag_id == PersonGroup.find(tag_id).tag_id )
# end
end
