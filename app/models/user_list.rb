class UserList < ActiveRecord::Base

  belongs_to :user_list_header, :class_name => "ListHeader", :foreign_key => "list_header_id"
  belongs_to :login_account, :foreign_key => "user_id"
  
  validates_presence_of :list_header_id, :user_id
  validates_uniqueness_of :list_header_id, :scope => :user_id
end
