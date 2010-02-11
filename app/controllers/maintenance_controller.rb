class MaintenanceController < ApplicationController
  # System Logging added

  require 'csv'

  # This relies heavily on the backup script in lib/tasks/backup_db.rake.
  # It assumes that in the specified backup directory the only thing the directory
  # contains are folder in the following format:
  # <year>-<month>-<day>_<24hour><min>-<sec>
  # eg 2009-10-10_01-00-05
  # and that inside that directory there should be a backup file of the database.

  def system_backup    

  end

  def backup
    file_name = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
    file_name = params[:file_name] + file_name unless params[:file_name].blank?
    cmd = "/usr/bin/ruby /usr/bin/rake -f ~/amazon/Rakefile rake:db:backup FILE=#{file_name}"
    redirect_to :action => 'backup_now', :cmd => cmd, :file_name => file_name
  end

  def backup_now  
    system  "#{params[:cmd]}"
    flash.now[:message] = "A back up - #{params[:file_name]} is available"
    respond_to do |format|
      format.js
    end
  end

  def system_restore
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) viewed system backups.")
    backup_directory = "/home/ubuntu/database/backup"
    dir = Dir.new(backup_directory) rescue dir = nil
    @backups = dir.nil? ? [] : (dir.entries - [".", ".."]).sort.reverse
  end

  def restore
    file_name = params[:file_name]
    dir = "/home/ubuntu/database/backup/" + file_name
    cmd = "/usr/bin/ruby /usr/bin/rake -f ~/amazon/Rakefile rake:db:restore DIR=#{dir} RAILS_ENV=#{RAILS_ENV}; /usr/bin/ruby /usr/bin/rake -f ~/amazon/Rakefile rake:db:patch RAILS_ENV=#{RAILS_ENV}"
    redirect_to :action => "restore_now", :cmd => cmd, :file_name => file_name
  end

  def restore_now
    system "#{params[:cmd]}"
    flash.now[:message] = "Database is restored using #{params[:file_name]}"
    respond_to do |format|
      format.js {render 'backup_now.js'}
    end
  end

  def import_postcodes
    # This screen is for us selecting the file and all the parameters for
    # the postcode import...

  end

  def import_postcode_file
    system_log("Login Account #{@current_user.user_name} (#{@current_user.id}) ran a postcode importation.")
    # This is where a submitted postcode form gets uploaded to
    suburb = params[:suburb]
    state = params[:state]
    postcode = params[:postcode]
    header_lines = params[:header_lines]
    country_id = params[:import_postcode][:country_id]
    update_option = params[:update_option]

    country = Country.find_by_id(country_id)

    header_lines = 0 if (header_lines.empty?)

    if (params[:postcode_file].nil? || country.nil? || (suburb.empty? && state.empty? || postcode.empty?))

      flash[:warning] = flash_message(:type => "field_missing", :field => "postcode data file") if params[:postcode_file].nil?
      flash[:warning] = flash_message(:type => "field_missing", :field => "postcode country") if country.nil?
      flash[:warning] = flash_message(:type => "field_missing", :field => "column numbers") if (suburb.empty? && state.empty? || postcode.empty?)
      redirect_to :action => "import_postcodes" , :controller => "maintenance" and return
    else
      # process_postcode_data(suburb, state, postcode, country, header_lines, update_option, postcode_file)
      MiddleMan.worker(:postcode_import_worker).async_process_postcode_data(:arg => {:suburb => suburb, :state => state, :postcode => postcode, :country => country, :header_lines => header_lines, :update_option => update_option, :postcode_file => "#{params[:postcode_file].first.path}" })

      flash[:warning] = flash_message(:message => "The postcode data is being added to the system in the background. Depending upon available system resources, it may take a while before all the data from the postcode import is processed.")
      redirect_to :action => "import_postcodes" , :controller => "maintenance" and return
    end
  end

  def country_data
    
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
