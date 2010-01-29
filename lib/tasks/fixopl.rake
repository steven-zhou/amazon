namespace :db do
  desc "Add Organsiation Primary List to old database"
  task :fixopl => :environment do
    opl = OrganisationPrimaryList.create(:name => "Organisation Primary List", :status => true)
    superuser = GroupType.find_by_name("Power User")
    GroupList.create(:tag_id => superuser.id, :list_header_id => opl.id)
    existing_organisations = Organisation.all
    existing_organisations.each do |i|
      ListDetail.create(:entity_id => i.id, :list_header_id => opl.id)
    end
  end
end
