class GroupPermission < ActiveRecord::Base

  belongs_to :system_permission_type
  #belongs_to :user_group

  belongs_to :group_type, :foreign_key => "user_group_id"

  validates_presence_of :system_permission_type_id, :user_group_id

  validates_uniqueness_of :system_permission_type_id, :scope => :user_group_id

end
