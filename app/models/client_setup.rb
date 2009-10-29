class ClientSetup < ActiveRecord::Base

  belongs_to :client_organisation, :class_name => "Organisation", :foreign_key => "organisation_id"
end
