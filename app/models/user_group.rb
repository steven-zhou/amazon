class UserGroup < ActiveRecord::Base


  belongs_to :login_account, :foreign_key => "user_id"
  belongs_to :group_type, :foreign_key => "group_id"

#  has_many :group_permissions
#  has_many :system_permission_types, :through => :group_permissions


  validates_presence_of :user_id
  validates_presence_of :group_id


  validates_uniqueness_of :user_id, :scope => :group_id


end
