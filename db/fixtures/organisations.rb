# Organisations Table
client = ClientOrganisation.create :full_name => "Client Organisation"
ClientSetup.create :organisation_id => client.id, :feedback_to => "feedback@memerzone.com.au", :reply_from => "feedback@memerzone.com.au", :superadmin_message => "superadmin message"