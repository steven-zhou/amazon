class GroupPermission < ActiveRecord::Base

  belongs_to :system_permission_type
  belongs_to :user_group

end
