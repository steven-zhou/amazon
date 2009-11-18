class Postcode < ActiveRecord::Base

  #Association
  belongs_to :country

  #Validation
  validates_presence_of :country_id
  validates_uniqueness_of :postcode

  #Default scope
  default_scope :order => "postcode ASC"

end
