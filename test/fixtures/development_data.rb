puts "Before importing this sample data for the development database make sure you've done a rake db:populate first."

puts "Creating sample SystemPermission data"
mdmmt = SystemPermissionMetaMetaType.create(:name => "Person", :status => true)
mdmt = SystemPermissionMetaType.create(:name => "Address_Controller", :system_permission_meta_meta_type => mdmmt, :status => true)
show = SystemPermissionType.create(:name => "Address_show", :system_permission_meta_type => mdmt, :status => true)
edit = SystemPermissionType.create(:name => "Address_edit", :system_permission_meta_type => mdmt, :status => true)
create = SystemPermissionType.create(:name => "Address_create", :system_permission_meta_type => mdmt, :status => true)
update = SystemPermissionType.create(:name => "Address_update", :system_permission_meta_type => mdmt, :status => true)
destroy = SystemPermissionType.create(:name => "Address_destroy", :system_permission_meta_type => mdmt, :status => true)
mdmt0 = SystemPermissionMetaType.create(:name => "Note_Controller", :system_permission_meta_meta_type => mdmmt, :status => true)
show0 = SystemPermissionType.create(:name => "Note_show", :system_permission_meta_type => mdmt0, :status => true)
edit0 = SystemPermissionType.create(:name => "Note_edit", :system_permission_meta_type => mdmt0, :status => true)
create0 = SystemPermissionType.create(:name => "Note_create", :system_permission_meta_type => mdmt0, :status => true)
update0 = SystemPermissionType.create(:name => "Note_update", :system_permission_meta_type => mdmt0, :status => true)
destroy0 = SystemPermissionType.create(:name => "Note_destroy", :system_permission_meta_type => mdmt0, :status => true)

mdmmt1 = SystemPermissionMetaMetaType.create(:name => "Admin", :status => true)
mdmt1 = SystemPermissionMetaType.create(:name => "group_list_controller", :system_permission_meta_meta_type => mdmmt1, :status => true)
showlist1 = SystemPermissionType.create(:name => "group_list_show_list", :system_permission_meta_type => mdmt1, :status => true)
create1 = SystemPermissionType.create(:name => "group_list_create", :system_permission_meta_type => mdmt1, :status => true)
destroy1 = SystemPermissionType.create(:name => "group_list_destroy", :system_permission_meta_type => mdmt1, :status => true)



puts "Creating Super Group."
supermetatype = GroupMetaMetaType.create(:name => "Super", :status => true)
supergroup = GroupMetaType.create(:name => "System Group", :group_meta_meta_type => supermetatype, :status => true)
superuser = GroupType.create(:name => "Super User", :group_meta_type => supergroup, :status => true)


puts "Creating Member Zone Super User"
memberzone = MemberZone.create(
  :user_name => "MemberZone",
  :password => "memberzone",
  :access_attempts_count => 3,
  :session_timeout => 3,
  :authentication_grace_period => 3
)


puts "Creating Super Admin"
superadmin = SuperAdmin.create(
  :user_name => "SuperAdmin",
  :password => "superadmin",
  :access_attempts_count => 3,
  :session_timeout => 3,
  :authentication_grace_period => 3
)

puts "Assign Group to Super Users."

UserGroup.create(:user_id => memberzone.id, :group_id => superuser.id)
UserGroup.create(:user_id => superadmin.id, :group_id => superuser.id)


puts "Assign Permission to Super User Group"
GroupPermission.create(:system_permission_type_id => show.id, :user_group_id => superuser.id)


puts "Assign List to Super User Group"
GroupList.create(:tag_id => superuser.id, :list_header_id => PrimaryList.first.id)


# People

puts "Creating sample people."

mr = Title.find_by_name("Mr")
mrs = Title.find_by_name("Mrs")
dr = Title.find_by_name("Dr")

male = Gender.find_by_name("Male")
female = Gender.find_by_name("Female")

christianity = Religion.find_by_name("Christianity")
buddhism = Religion.find_by_name("Buddhism")

english = Language.find_by_name("English")
spanish = Language.find_by_name("Spanish")
chinese = Language.find_by_name("Chinese")
french = Language.find_by_name("French")

single = MaritalStatus.find_by_name("Single")
married = MaritalStatus.find_by_name("Married")
divorced = MaritalStatus.find_by_name("Divorced")

gov = IndustrySector.find_by_name("Goverment")
private = IndustrySector.find_by_name("Private")


australia = Country.find_by_short_name("Australia")
china = Country.find_by_short_name("China")
india = Country.find_by_short_name("India")

puts "Creating Robert Tingle"
robert_tingle = Person.create(
  :custom_id => "89567",
  :industry_sector_id => gov.id,
  :primary_title_id => mr.id,
  :first_name => "Robert",
  :family_name => "Tingle",
  :preferred_name => "Bob",
  :gender_id => male.id,
  :marital_status_id => single.id,
  :religion_id => christianity.id,
  :origin_country_id => australia.id,
  :residence_country_id => australia.id,
  :nationality_id => australia.id,
  :language_id => english.id,
  :other_language_id => spanish.id,
  :onrecord_since => 1.year.ago
)

puts "Creating login for Robert Tingle"
robert_tingle_login = SystemUser.create(
  :person_id => robert_tingle.id,
  :user_name => "username",
  :password => "password",
  :security_email => "feedback@memberzone.com.au",
  :password_confirmation => "password",
  :security_question1_id => "89",
  :security_question2_id => "89",
  :security_question3_id => "89",
  :question1_answer => "1",
  :question2_answer => "2",
  :question3_answer => "3",
  :access_attempts_count => 3,
  :session_timeout => 3,
  :authentication_grace_period => 3
)

puts "Creating Jackie Chan"
jackie_chan = Person.create(
  :custom_id => "548514",
  :industry_sector_id => private.id,
  :primary_title_id => dr.id,
  :first_name => "Jackie",
  :family_name => "Chan",
  :preferred_name => "The Dragon",
  :gender_id => male.id,
  :marital_status_id => married.id,
  :religion_id => buddhism.id,
  :origin_country_id => china.id,
  :residence_country_id => china.id,
  :nationality_id => china.id,
  :language_id => china.id,
  :other_language_id => english.id,
  :onrecord_since => 100.days.ago
)

puts "Creating Sarah Clarkson"
sarah_clarkson = Person.create(
  :custom_id => "257854",
  :industry_sector_id => gov.id,
  :primary_title_id => mrs.id,
  :first_name => "Sarah",
  :family_name => "Clarkson",
  :gender_id => female.id,
  :marital_status_id => divorced.id,
  :religion_id => buddhism.id,
  :origin_country_id => china.id,
  :residence_country_id => australia.id,
  :nationality_id => china.id,
  :language_id => chinese.id,
  :other_language_id => english.id,
  :onrecord_since => 36.days.ago
)

puts "Creating Bill Woo"
bill_woo = Person.create(
  :custom_id => "7846552",
  :industry_sector_id => gov.id,
  :primary_title_id => mr.id,
  :second_title_id => dr.id,
  :first_name => "William",
  :family_name => "Woo",
  :preferred_name => "Bill",
  :gender_id => male.id,
  :marital_status_id => divorced.id,
  :religion_id => buddhism.id,
  :origin_country_id => china.id,
  :residence_country_id => australia.id,
  :nationality_id => china.id,
  :language_id => chinese.id,
  :other_language_id => english.id,
  :onrecord_since => 212.days.ago
)

puts "Creating Karen Smith"
karen_smith = Person.create(
  :custom_id => "3258714",
  :industry_sector_id => gov.id,
  :primary_title_id => mrs.id,
  :second_title_id => dr.id,
  :first_name => "Karen",
  :family_name => "Smith",
  :gender_id => female.id,
  :marital_status_id => single.id,
  :religion_id => christianity.id,
  :origin_country_id => australia.id,
  :residence_country_id => india.id,
  :nationality_id => australia.id,
  :language_id => english.id,
  :other_language_id => french.id,
  :onrecord_since => 586.days.ago
)

# MasterDoc Data

puts "Creating sample MasterDoc data."

mdmmt = MasterDocMetaMetaType.create(:name => "Licences", :status => true)

mdmt = MasterDocMetaType.create(:name => "Airplane", :master_doc_meta_meta_type => mdmmt, :status => true)
boeing_747 = MasterDocType.create(:name => "Boeing 747", :master_doc_meta_type => mdmt, :status => true)
boeing_737 = MasterDocType.create(:name => "Boeing 737", :master_doc_meta_type => mdmt, :status => true)
paper_aeroplane = MasterDocType.create(:name => "Paper aeroplane", :master_doc_meta_type => mdmt, :status => true)

mdmt = MasterDocMetaType.create(:name => "Road Vehicles", :master_doc_meta_meta_type => mdmmt, :status => true)
huge_truck = MasterDocType.create(:name => "Huge Truck", :master_doc_meta_type => mdmt, :status => true)
little_truck = MasterDocType.create(:name => "Little Truck", :master_doc_meta_type => mdmt, :status => true)
car = MasterDocType.create(:name => "Car", :master_doc_meta_type => mdmt, :status => true)

mdmmt = MasterDocMetaMetaType.create(:name => "Identification", :status => true)

mdmt = MasterDocMetaType.create(:name => "Government Issued", :master_doc_meta_meta_type => mdmmt, :status => true)
passport = MasterDocType.create(:name => "Passport", :master_doc_meta_type => mdmt, :status => true)
drivers_licence = MasterDocType.create(:name => "Drivers Licence", :master_doc_meta_type => mdmt, :status => true)
national_id_card = MasterDocType.create(:name => "National ID Card", :master_doc_meta_type => mdmt, :status => true)

puts "Creating sample Group data."

mdmmt = GroupMetaMetaType.create(:name => "Security", :status => true)

mdmt = GroupMetaType.create(:name => "System Users", :group_meta_meta_type => mdmmt, :status => true)
admin = GroupType.create(:name => "Admin", :group_meta_type => mdmt, :status => true)
operators = GroupType.create(:name => "Operators", :group_meta_type => mdmt, :status => true)
volunteers = GroupType.create(:name => "Volunteers", :group_meta_type => mdmt, :status => true)
auditor = GroupType.create(:name => "Auditor", :group_meta_type => mdmt, :status => true)
mdmt = GroupMetaType.create(:name => "Members", :group_meta_meta_type => mdmmt, :status => true)

mdmmt = GroupMetaMetaType.create(:name => "Custom", :status => true)

mdmt = GroupMetaType.create(:name => "Public", :group_meta_meta_type => mdmmt, :status => true)





puts "Assign Group to person_id 1."

pg = UserGroup.create(:user_id => robert_tingle_login.id, :group_id => admin.id)

puts "Assign Permission to group pg"
permission = GroupPermission.create(:system_permission_type_id => show.id, :user_group_id => admin.id)

puts "Adding the first login account to the primary list"

pl = PrimaryList.first
pl.group_types << pg.group_type


puts "Creating passport for Robert Tingle"
MasterDoc.create(
  :entity => robert_tingle,
  :master_doc_type_id => passport.id,
  :doc_number => "L74383956",
  :name_on_doc => "Robert R Tingle",
  :issue_organisation => "Australian Government",
  :issue_place => "Sydney, Australia"
)

puts "Creating drivers licence for Robert Tingle"
MasterDoc.create(
  :entity => robert_tingle,
  :master_doc_type_id => drivers_licence.id,
  :doc_number => "12643116",
  :name_on_doc => "Robert Rick Tingle",
  :issue_organisation => "RTA",
  :issue_state => "NSW"
)

puts "Creating Boeing 747 licence for Jackie Chan."
MasterDoc.create(
  :entity => jackie_chan,
  :master_doc_type_id => boeing_747.id,
  :doc_number => "65875545325358",
  :name_on_doc => "Jackie Chan",
  :issue_organisation => "Boeing Corporation"
)

# Contacts

puts "Creating sample contacts."

email_work = ContactMetaType.find(:first, :conditions => ["tag_meta_type_id = ? and name = 'Work'", ContactMetaMetaType.find_by_name("Email").id])
email_personal = ContactMetaType.find(:first, :conditions => ["tag_meta_type_id = ? and name = 'Personal'", ContactMetaMetaType.find_by_name("Email").id])
phone_mobile = ContactMetaType.find(:first, :conditions => ["tag_meta_type_id = ? and name = 'Mobile'", ContactMetaMetaType.find_by_name("Phone").id])
phone_home = ContactMetaType.find(:first, :conditions => ["tag_meta_type_id = ? and name = 'Home'", ContactMetaMetaType.find_by_name("Phone").id])
website_business = ContactMetaType.find(:first, :conditions => ["tag_meta_type_id = ? and name = 'Business'", ContactMetaMetaType.find_by_name("Website").id])



puts "Creating email for Sarah Clarkson"
Email.create(
  :contactable => sarah_clarkson,
  :contact_meta_type_id => email_personal.id,
  :value => "sarah.clarkson@gmail.com"
)

puts "Creating email for Jackie Chan"
Email.create(
  :contactable => jackie_chan,
  :contact_meta_type_id => email_work.id,
  :value => "the_dragon@hotmail.com"
)

puts "Creating Phone for Robert Tingle"
Phone.create(
  :contactable => robert_tingle,
  :contact_meta_type_id => phone_mobile.id,
  :value => "0410258698"
)

puts "Creating Phone for Jackie Chan"
Phone.create(
  :contactable => robert_tingle,
  :contact_meta_type_id => phone_home.id,
  :pre_value => "02",
  :value => "82564521"
)

puts "Creating Phone for Karen Smith"
Phone.create(
  :contactable => karen_smith,
  :contact_meta_type_id => phone_mobile.id,
  :value => "0458759565"
)

puts "Creating Website for Jackie Chan"
Website.create(
  :contactable => jackie_chan,
  :contact_meta_type_id => website_business.id,
  :value => "www.jackiechan.com"
)


# Addresses

# Keywords

# Masterdocs

# Sample postcodes

puts "Creating some sample postcodes"

c = Country.find_by_short_name("Australia")
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Epping", :state => "NSW", :postcode => "2121")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Hornsby", :state => "NSW", :postcode => "2065")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Chatswood", :state => "NSW", :postcode => "2066")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "St Leonards", :state => "NSW", :postcode => "2065")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Brisbane", :state => "QLD", :postcode => "4000")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Perth", :state => "WA", :postcode => "5000")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Beerville", :state => "WA", :postcode => "5001")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Adelaide", :state => "SA", :postcode => "6000")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Darlinghurst", :state => "NSW", :postcode => "2001")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Balmain", :state => "NSW", :postcode => "2002")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Newtown", :state => "NSW", :postcode => "2003")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Alexandria", :state => "NSW", :postcode => "2004")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Five Dock", :state => "NSW", :postcode => "2005")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Carlingford", :state => "NSW", :postcode => "2006")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Terry Hills", :state => "NSW", :postcode => "2007")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Waverton", :state => "NSW", :postcode => "2008")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Double Bay", :state => "NSW", :postcode => "2009")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Roseville", :state => "NSW", :postcode => "2010")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Lindfield", :state => "NSW", :postcode => "2011")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Gordon", :state => "NSW", :postcode => "2012")
d.save
d = DomesticPostcode.new(:country_id => c.id, :suburb => "Killara", :state => "NSW", :postcode => "2013")
d.save

puts "Creating Sample Modules Data"
AvailableModulde.create(
  :name => "Fundrising",
  :description => "Fundrising",
  :status => true
)
AvailableModulde.create(
  :name => "MyCase",
  :description => "MyCase",
  :status => true
)
AvailableModulde.create(
  :name => "MemberZone",
  :description => "MemberZone",
  :status => true
)
AvailableModulde.create(
  :name => "UnknownModule",
  :description => "UnknownModule",
  :status => true
)

