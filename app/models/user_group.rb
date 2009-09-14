class UserGroup < ActiveRecord::Base


  belongs_to :login_account, :foreign_key => "user_id"
  belongs_to :group, :foreign_key => "group_id"


  validates_presence_of :user_id
  validates_presence_of :group_id


  validates_uniqueness_of :group_id, :scope => :user_id





end
