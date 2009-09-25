class CompileList < ActiveRecord::Base

  belongs_to :login_account
  belongs_to :list_header
end
