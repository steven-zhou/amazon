# Organisations Table
client = ClientOrganisation.create :full_name => "Google", :short_name => "Google", :trading_as => "Google", :registered_name => "Google", :registered_number => "0032dkkf832"
ClientSetup.create :organisation_id => client.id, :client_id => "007"