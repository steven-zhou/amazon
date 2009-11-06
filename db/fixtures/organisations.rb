# Organisations Table
client = ClientOrganisation.create :full_name => "Client Organisation"
ClientSetup.create :organisation_id => client.id