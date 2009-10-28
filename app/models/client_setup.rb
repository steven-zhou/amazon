class ClientSetup < ActiveRecord::Base

  has_one :client_organisation, :foreign_key => "organisation_id"
end
