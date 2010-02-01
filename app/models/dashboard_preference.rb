class DashboardPreference < ActiveRecord::Base

  belongs_to :login_account

  #--
  ################
  #  Validations
  ################
  #++

  validates_presence_of :box_id, :column_id
  validates_uniqueness_of :box_id, :scope => "column_id"

  def self.user_column(user, num)
    @column = DashboardPreference.find(:all, :conditions => ["login_account_id = ? and column_id = ?", user, num], :order => "id")
  end

end
