class CompileList < ActiveRecord::Base

  belongs_to :login_account
  belongs_to :list_header

  validates_uniqueness_of :list_header_id, :scope => [:login_account_id]
end
