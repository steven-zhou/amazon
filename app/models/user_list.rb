class UserList < ActiveRecord::Base



  belongs_to :list_header
  belongs_to :login_account, :foreign_key => "user_id"

end
