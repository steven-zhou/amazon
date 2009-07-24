class OrganisationKeyPersonnel < ActiveRecord::Base

  belongs_to :person
  belongs_to :organisation

  
end
