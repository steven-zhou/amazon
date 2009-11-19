class Postcode < ActiveRecord::Base

  #Association
  belongs_to :country
  has_many :geographical_area, :foreign_key => "geo_area_id"
  has_many :electoral_area, :foreign_key => "electoral_area_id"

  #Validation
  validates_presence_of :country_id, :postcode
  validates_uniqueness_of :postcode, :scope => 'country_id'

  #Default scope
  default_scope :order => "postcode ASC"

end
