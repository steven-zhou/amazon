namespace :db do
  desc "To delete the data"
  task :nightly_process_tasks => :environment do
    Dir[File.join(RAILS_ROOT, 'db', 'nightly_process', '*.rb')].sort.each { |fixture| load fixture }
    Dir[File.join(RAILS_ROOT, 'db', 'nightly_process', RAILS_ENV, '*.rb')].sort.each { |fixture| load fixture }
  end
end