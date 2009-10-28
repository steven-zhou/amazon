class MaintenanceController < ApplicationController

  # This relies heavily on the backup script in lib/tasks/backup_db.rake.
  # It assumes that in the specified backup directory the only thing the directory
  # contains are folder in the following format:
  # <year>-<month>-<day>_<24hour><min>-<sec>
  # eg 2009-10-10_01-00-05
  # and that inside that directory there should be a backup file of the database.

  def system_backup


  end


  def system_restore
    backup_directory = "/home/rails/database/backup"
    @backups = Array.new
    if ( File.exists?(backup_directory) && File.directory?(backup_directory) && File.readable?(backup_directory) )
      available_backups = Dir.entries(backup_directory) - ["..", "."]
      for backup in available_backups do
        backup = backup_directory_tidy(backup)
        @backups << bacup unless backup.empty?
      end
    end
  end

  private

  def backup_directory_tidy(directory)
    #The input should match 2009-10-10_01-00-05 and return
    # Sat 10 Oct 2009 01:00:05 AM
    # If the string cannot be parsed it should return blank

    return "" unless directory =~ /^\d{4}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}$/
    date_time = directory.split(/_/)
    directory_date = date_time.first.to_date.strftime('%a %d %b %Y')
    directory_time = date_time.second.gsub(/-/, ':')

    return "#{directory_date} #{directory_time}"


  end

end
