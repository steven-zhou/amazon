set :domain, "amazon-production"
set :branch, "development"
server "amazon-production", :app, :web, :db, :primary => true

