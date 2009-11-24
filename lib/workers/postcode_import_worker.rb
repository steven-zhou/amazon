class PostcodeImportWorker < BackgrounDRb::MetaWorker
  set_worker_name :postcode_import_worker
  def create(args = nil)
    # this method is called, when worker is loaded for the first time
  end

  def process_postcode_data(arg)

    ShowPostcodeGrid.destroy_all # Clear out our flexigrid results table...

    suburb = arg[:suburb]
    state = arg[:state]
    postcode = arg[:postcode]
    country = arg[:country]
    header_lines = arg[:header_lines]
    update_option = arg[:update_option]
    postcode_file = File.open("#{arg[:postcode_file]}")
    
    # puts "Processing Postcode Data with: Suburb Col #{suburb} State Col #{state} Postcode #{postcode} Country #{country.id} Header Lines #{header_lines} Update Option #{update_option} Postcode File #{postcode_file}"

    Postcode.destroy_all if update_option.to_s == "overwrite"

    i = 1 # We start at the first line
    while row = postcode_file.readline
      if i <= "#{header_lines}".to_i
        # Do nothing
      else
        data = row.split(/,/)

        if update_option == "update"
          # Find existing matching records
        else
          dp = Postcode.new
          suburb_index = suburb.to_i - 1
          state_index = state.to_i - 1
          postcode_index = postcode.to_i - 1

          dp.suburb = ( suburb_index >= 0 && !data[suburb_index].nil? && !data[suburb_index].empty? ) ? data[suburb_index].gsub(/\"/,'').humanize : ""
          dp.state = ( state_index >= 0 && !data[state_index].nil? && !data[state_index].empty? ) ? data[state_index].gsub(/\"/,'').humanize.upcase : ""
          dp.postcode = ( postcode_index >= 0 && !data[postcode_index].nil? && !data[postcode_index].empty? ) ? data[postcode_index].gsub(/\"/,'').humanize : ""
          dp.country = country
          dp.country_name = country.short_name

          dp.save

        end

      end

      i += 1

    end
  end

end

