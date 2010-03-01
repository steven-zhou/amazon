puts "Destroy People"

primary_list = PrimaryList.first.list_details
person_list_headers = PersonListHeader.all

Person.find(:all,:conditions=>["to_be_removed = true"]).each do |person|

#  puts "Destroy People on the user group"
#
#  person_on_user_group = UserGroup.find_by_user_id(person.id)
#  person_on_user_group.destroy unless person_on_user_group.nil?
#
#  puts "Destroy People on the user list"
#
#  person_on_user_list = UserList.find_by_user_id(person.id)
#  person_on_user_list.destroy unless person_on_user_list.nil?




     person_list_headers.each do |person_list_header|

      person_on_list = person_list_header.list_details.find_by_entity_id(person.id)

      puts "Destroy People on list"
      person_on_list.destroy unless person_on_list.nil?

  end

  list_detail = primary_list.find_by_entity_id(person.id)

  puts "Destroy People on Primary List Detail"
  list_detail.destroy unless list_detail.nil?

  person.destroy
end


puts "Destroy Organisation"
org_primary_list = OrganisationPrimaryList.first.list_details
org_list_headers = OrganisationListHeader.all

Organisation.find(:all,:conditions=>["to_be_removed = true"]).each do |org|

  org_list_headers.each do |org_list_header|
    org_on_list = org_list_header.list_details.find_by_entity_id(org.id)
    puts "Destroy Organisation on list"
    org_on_list.destroy unless org_on_list.nil?
  end

  org_list_detail = org_primary_list.find_by_entity_id(org.id)

  puts "Destroy Org on Primary List Detail"
  org_list_detail.destroy unless org_list_detail.nil?

  org.destroy
end
