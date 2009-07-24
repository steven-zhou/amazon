class Organisation < ActiveRecord::Base

  has_many :organisation_key_personnels
  has_many :key_people, :through => :organisation_key_personnels, :source => :person

  belongs_to :country, :foreign_key => :registered_country_id

  belongs_to :organisation_hierarchy

end
