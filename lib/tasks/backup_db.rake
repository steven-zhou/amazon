require 'find'
require 'ftools'
namespace :db do
  desc "Backup the database to a file. Options: DIR=base_dir FILE=file_name RAILS_ENV=production MAX=20"
  environment = RAILS_ENV # Not sure why we have to do this hack, but it seems to work
  task :backup => [:environment] do
    RAILS_ENV = environment
    puts "Backup environment is #{RAILS_ENV}"
    datestamp = ENV["FILE"] || Time.now.strftime("%Y-%m-%d_%H-%M-%S")
    base_path = ENV["DIR"] || "/home/ubuntu/database/backup"
    backup_folder = File.join(base_path, datestamp)
    puts "Backup folder = #{backup_folder}"
    File.makedirs(backup_folder)
    db_config = ActiveRecord::Base.configurations[RAILS_ENV]
    sh "pg_dump -U rails -O --format=t -f #{RAILS_ENV}_dump.tar #{db_config['database']}"
    sh "mv #{RAILS_ENV}_dump.tar #{backup_folder}/#{RAILS_ENV}_dump.tar"
    dir = Dir.new(base_path)
    all_backups = (dir.entries - [".", ".."]).sort.reverse
    puts "Created backup: #{backup_folder}/#{RAILS_ENV}_dump.tar"
    max_backups = (ENV["MAX"] || 20).to_i
    unwanted_backups = all_backups[max_backups..-1] || []
    for unwanted_backup in unwanted_backups
      FileUtils.rm_rf(File.join(base_path, unwanted_backup))
      puts "deleted #{unwanted_backup}"
    end
    puts "Deleted #{unwanted_backups.length} backups,
      #{all_backups.length - unwanted_backups.length} backups available"
  end
end

namespace :db do
  desc 'Restore the database from a file. Options: DIR=source_dir RAILS_ENV=production'
  environment = RAILS_ENV
  task :restore => [:environment] do
    RAILS_ENV = environment
    puts "Restore environment is #{RAILS_ENV}"
    datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
    source_path = ENV["DIR"] || "~/database/backup"
    source_file = File.join(source_path, "#{RAILS_ENV}_dump.tar")
    db_config = ActiveRecord::Base.configurations[RAILS_ENV]
    sh "pg_restore -U rails -O -c -d #{db_config['database']} #{source_file}"

    puts "Restored database from a backup file: #{source_file}"
  end
end