puts "\nPostcode Importer -- for importing postcodes from the command line.\n\n"
puts "Useage: postcode_importer.rb <file_name>\n\n"

# Customise these for the file we are importing

file = ARGV[0].to_s
update_option = "overwrite" # Can be overwrite or append
header_lines = 0 # Number of lines to skip in the header

suburb_col = 1
state_col = 2
postcode_col = 3
country = Country.find_by_short_name("Australia")
# End of custom settings

if (!File.exists?(file) || !File.file?(file) || !File.readable?(file))
  puts "There was an error loading the postcode file you specified."
  exit
else
  file = File.open(file)
end

Postcode.destroy_all if update_option.to_s == "overwrite"

i = 1 # We start at the first line
while row = file.readline
  if i <= "#{header_lines}".to_i
    # Do nothing
  else
    data = row.split(/,/)

    dp = Postcode.new
    suburb_index = suburb_col.to_i - 1
    state_index = state_col.to_i - 1
    postcode_index = postcode_col.to_i - 1

    dp.suburb = ( suburb_index >= 0 && !data[suburb_index].nil? && !data[suburb_index].empty? ) ? data[suburb_index].gsub(/\"/,'').humanize : ""
    dp.state = ( state_index >= 0 && !data[state_index].nil? && !data[state_index].empty? ) ? data[state_index].gsub(/\"/,'').humanize.upcase : ""
    dp.postcode = ( postcode_index >= 0 && !data[postcode_index].nil? && !data[postcode_index].empty? ) ? data[postcode_index].gsub(/\"/,'').humanize : ""
    dp.country = country
    dp.country_name = country.short_name

    if dp.save
      puts "Saved entry with Suburb #{dp.suburb} State #{dp.state} Postcode #{dp.postcode} Country #{country.short_name}"
    else
      puts "There was an error processing row: #{data}"
    end

  end

  i += 1

end

