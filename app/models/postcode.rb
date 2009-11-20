class Postcode < ActiveRecord::Base

  #Association
  belongs_to :country
  has_many :geographical_area
  has_many :electoral_area

  #Validation
  validates_presence_of :country_id, :postcode, :state, :suburb, :geographical_area_id, :electoral_area_id
  validates_uniqueness_of :postcode, :state, :suburb, :scope => 'country_id', :case_sensitive => false

  #Default scope
  default_scope :order => "postcode ASC"

end
