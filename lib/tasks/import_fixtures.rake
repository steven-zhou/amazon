desc "Populates default data required for the app from the fixtures into the development database."
namespace :db  do
  namespace :fixtures do
      task :development_import => :environment do


        RAILS_ENV = "development"
        
        require 'active_record/fixtures'
        require 'rake'
        ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
        ## set directory to import
        file_base_path = File.join(RAILS_ROOT, 'test', 'fixtures')
        puts "importing from: " + file_base_path

        puts "the RAILS_ENV is " + RAILS_ENV

        if ENV["TABLE"] != nil
            files_array = ENV["TABLE"].to_s.split(",")
        else
            files_array = Dir.glob(File.join(file_base_path, '*.{yml}'))
        end

        files_array.each do |fixture_file|
            puts "\n Importing " + File.basename(fixture_file.strip, ".yml") + "..."
            begin
                  if fixture_file.downcase != 'schema_info'
                    Fixtures.create_fixtures(file_base_path, File.basename(fixture_file.strip, '.yml'))
                  else
                    raise   "Not willing to import schema_info!"
                  end
                puts    " Status: Completed"
            rescue
                puts    " Status: Aborted\n\n" + $!
            end
        end
        puts "\nTask completed!"

      end
    end
end
