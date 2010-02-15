set :domain, "amazon-development"
set :branch , "development"
server "amazon-development", :app, :web, :db, :primary => true
