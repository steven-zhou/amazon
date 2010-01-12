Factory.define :client_setup do |f|
  f.association :client_organisation, :factory => :google
end