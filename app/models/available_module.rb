class AvailableModule < ActiveRecord::Base

  default_scope :order => "name"
end
