class Postcode < ActiveRecord::Base

  validates_presence_of :country_id, :message => "You must specify a country for this postcode."
  belongs_to :country

end
