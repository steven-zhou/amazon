Factory.define :client_setups do |f|
  f.client "007"
  f.client_rego "client organisation registration"
  f.association :client_organisation, :factory => :google
end