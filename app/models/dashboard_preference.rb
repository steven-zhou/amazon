class DashboardPreference < ActiveRecord::Base

  belongs_to :login_account

  #--
  ################
  #  Validations
  ################
  #++

  validates_presence_of :box_id, :column_id
  validates_uniqueness_of :box_id, :scope => "column_id"

end
