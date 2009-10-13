class ExcludeList < CompileList

  validates_uniqueness_of :list_header_id, :scope => [:login_account_id]
end
