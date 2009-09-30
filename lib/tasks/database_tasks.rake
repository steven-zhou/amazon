namespace :db do
  desc "Resets the current database and loads up development data."
  task :reset_development => [:environment, 'db:drop', 'db:create', 'db:migrate', 'db:populate'] do
    runner_command = "#{RAILS_ROOT}/script/runner #{RAILS_ROOT}/test/fixtures/development_data.rb"
   sh "#{runner_command}"
  end unless RAILS_ENV != "development"
end

namespace :db do
  desc 'Rolls the schema back to the previous version. Specify the number of steps with STEP=n'
  task :rollback => :environment do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    version = ActiveRecord::Migrator.current_version - step
    ActiveRecord::Migrator.migrate('db/migrate/', version)
  end
end