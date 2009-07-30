class Organisation < ActiveRecord::Base

  has_many :organisation_key_personnels
  has_many :key_people, :through => :organisation_key_personnels, :source => :person
  has_many :employments
  has_many :employees, :through => :employments, :source => :employee

  belongs_to :country, :foreign_key => :registered_country_id
  belongs_to :organisation_hierarchy
end
