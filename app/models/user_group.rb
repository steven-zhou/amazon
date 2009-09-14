class UserGroup < ActiveRecord::Base


  belongs_to :login_account, :foreign_key => "user_id"
  belongs_to :group


  validates_presence_of :user_id
  validates_presence_of :group_id

  validate :doctype_must_exist
  validate :role_must_exist

  validates_uniqueness_of :group_id, :scope => :user_id


  def doctype_must_exist
    errors.add(:user_id, "You must specify a doctype that exists.") if (user_id && MasterDocType.find_by_id(user_id).nil?)
  end
  def role_must_exist
    errors.add(:group_id, "You must specify a role that exists.") if (group_id && Role.find_by_id(group_id).nil?)
  end
  


end
