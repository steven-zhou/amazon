class MaintenanceController < ApplicationController

  require 'csv'

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
    # if ( File.exists?(backup_directory) && File.directory?(backup_directory) && File.readable?(backup_directory) )
    if (true)
      # available_backups = (Dir.entries(backup_directory) - ["..", "."]).stort
      available_backups = ["2009-10-10_01-00-05", "2009-10-26_01-00-07", "2009-10-25_01-00-10", "2009-10-22_01-00-06", "2009-10-16_01-00-07", "2009-10-11_01-00-06", "2009-10-14_01-00-05", "2009-10-20_01-00-06", "2009-10-18_01-00-06", "2009-10-15_01-00-06", "2009-10-21_01-00-06", "2009-10-12_01-00-06", "2009-10-19_01-00-09", "2009-10-13_01-00-06", "2009-10-28_01-00-06", "2009-10-17_01-00-06", "2009-10-24_01-00-07", "2009-10-23_01-00-06", "2009-10-27_01-00-06", "2009-10-29_01-00-06"].sort.reverse
      for backup in available_backups do
        backup = backup_directory_tidy(backup)
        @backups << backup unless backup.empty?
      end
    end
  end

  def import_postcodes
    # This screen is for us selecting the file and all the parameters for
    # the postcode import...

  end

  def import_postcode_file
    # This is where a submitted postcode form gets uploaded to
    suburb = params[:suburb]
    state = params[:state]
    postcode = params[:postcode]
    header_lines = params[:header_lines]
    country_id = params[:import_postcode][:country_id]
    update_option = params[:update_option]

    puts "Suburb #{suburb} State #{state} Postcode #{postcode} Header Lines #{header_lines} Update #{update_option}"

    country = Country.find_by_id(country_id)

    header_lines = 0 if (header_lines.empty?)

    if (params[:postcode_file].nil? || country.nil? || (suburb.empty? && state.empty? || postcode.empty?))

      flash[:warning] = flash_message(:type => "field_missing", :field => "postcode data file") if params[:postcode_file].nil?
      flash[:warning] = flash_message(:type => "field_missing", :field => "postcode country") if country.nil?
      flash[:warning] = flash_message(:type => "field_missing", :field => "column numbers") if (suburb.empty? && state.empty? || postcode.empty?)
      redirect_to :action => "import_postcodes" , :controller => "maintenance" and return
    else

      puts "Update options is #{update_option}"
      puts "Does it equal overwrite? #{update_option.to_s == 'overwrite'}"
      DomesticPostcode.destroy_all if update_option.to_s == "overwrite"

      row_success = 0
      row_fail = 0

      i = 1 # We start at the first line
      while row = params[:postcode_file].first.gets

        if i < header_lines
          # Do nothing
        else
          data = row.split(/,/)

          if update_option == "update"
            # Find existing matching records
          else
            dp = DomesticPostcode.new
            suburb_index = suburb.to_i - 1
            state_index = state.to_i - 1
            postcode_index = postcode.to_i - 1


            dp.suburb = "#{cleanup_csv_cell(data[suburb_index])}" if suburb_index >= 0
            dp.state = "#{cleanup_csv_cell(data[state_index]).upcase}" if state_index >= 0
            dp.postcode = "#{cleanup_csv_cell(data[postcode_index])}" if postcode_index >= 0
            dp.country = country

            if dp.save
              row_success += 1
            else
              row_fail += 1
            end

          end

        end
        
        i += 1

      end

      flash[:message] = flash_message(:message => "#{row_success} records were processed correctly. #{row_fail} rows had errors.")
      redirect_to :action => "import_postcodes" , :controller => "maintenance" and return

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

  def cleanup_csv_cell(data)
    data.gsub(/\"/,'').humanize

  end


end
