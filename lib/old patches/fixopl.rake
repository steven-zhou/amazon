namespace :db do
  desc "Add Organsiation Primary List to old database"
  task :fixopl => :environment do
    puts "Run Patch fixopl ..."
    if OrganisationPrimaryList.first.nil?
      puts "Create Organisation Primary List"
      opl = OrganisationPrimaryList.create(:name => "Organisation Primary List", :status => true)
      superuser = GroupType.find_by_name("Power User")
      GroupList.create(:tag_id => superuser.id, :list_header_id => opl.id)
      existing_organisations = Organisation.all
      existing_organisations.each do |i|
        ListDetail.create(:entity_id => i.id, :list_header_id => opl.id)
      end
    else
      puts "Organisation Primary List already exists"
    end
    puts "DONE"
  end
end
