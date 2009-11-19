class Postcode < ActiveRecord::Base

  #Association
  belongs_to :country
  has_many :geographical_area, :foreign_key => "geo_area_id"
  has_many :elect_area, :class => "ElectoralArea", :foreign_key => "elec_area_id"

  #Validation
  validates_presence_of :country_id
  validates_uniqueness_of :postcode

  #Default scope
  default_scope :order => "postcode ASC"

end
