puts "Destroy Country Data"


Country.find(:all,:conditions=>["to_be_removed = true"]).each do |country|

  unless country.organisations.empty? && Address.find_by_country_id(country.id).nil?
    country.to_be_removed = false
    country.save

  else

    country.destroy
  end

end

puts "Destroy Post Area"


PostArea.find(:all,:conditions=>["to_be_removed = true"]).each do |postarea|
  postarea.destroy
end


puts "Destroy Postcode"
Postcode.find(:all,:conditions=>["to_be_removed = true"]).each do |postcode|
  postcode.destroy
end


puts "Destroy Language"

Language.find(:all,:conditions=>["to_be_removed = true"]).each do |language|

  unless Country.find_by_main_language_id(language.id).nil? && Person.find_by_language_id(language.id).nil?
    language.to_be_removed = false
    language.save

  else

    language.destroy
  end

end



puts "Destroy Religion"

Religion.find(:all,:conditions=>["to_be_removed = true"]).each do |religion|
  unless  Person.find_by_religion_id(religion.id).nil?
    religion.to_be_removed = false
    religion.save

  else

    religion.destroy
  end

end