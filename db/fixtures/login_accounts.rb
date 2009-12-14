puts "Initializing Client Organisation and Client Setups"
client = ClientOrganisation.create :full_name => "Client Organisation", :level => '0'
ClientSetup.create :organisation_id => client.id, :feedback_to => "feedback@memerzone.com.au", :reply_from => "feedback@memerzone.com.au", :superadmin_message => "superadmin message", :level_0_label => "level_0", :level_1_label => "level_1", :level_2_label => "level_2"

puts "Initializing SystemPermission data"
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


puts "Initializing Custom Group."
custom = GroupMetaMetaType.create(:name => "Custom", :status => true)
security = GroupMetaMetaType.create(:name => "Security", :status => true)
mdmt = GroupMetaType.create(:name => "System Users", :group_meta_meta_type => security, :status => true)
admin = GroupType.create(:name => "Admin", :group_meta_type => mdmt, :status => true)

puts "Initializing Super Group."
supermetatype = GroupMetaMetaType.create(:name => "MemberZone", :status => true)
supergroup = GroupMetaType.create(:name => "Power Group", :group_meta_meta_type => supermetatype, :status => true)
superuser = GroupType.create(:name => "Power User", :group_meta_type => supergroup, :status => true)


puts "Initializing Member Zone Super User"
memberzone = MemberZone.create(
  :user_name => "MemberZone",
  :password => "memberzone123",
  :access_attempts_count => 99,
  :session_timeout => 999999,
  :authentication_grace_period => 9,
  :password_by_admin => false,
  :password_lifetime => 365,
  :login_status => true
)

puts "Initializing Super Admin"
superadmin = SuperAdmin.create(
  :user_name => "SuperAdmin",
  :password => "superadmin",
  :access_attempts_count => 99,
  :session_timeout => 30,
  :authentication_grace_period => 9,
  :password_by_admin => false,
  :password_lifetime => 365,
  :login_status => true
)

puts "Initializing password for member zone user"
client_setup = ClientSetup.first
client_setup.member_zone_power_password = "123456"
client_setup.super_admin_power_password = "123456"
client_setup.save

puts "Initializing Group to Super Users."

UserGroup.create(:user_id => memberzone.id, :group_id => superuser.id)
UserGroup.create(:user_id => superadmin.id, :group_id => superuser.id)


puts "Initializing Permission to Super User Group"
GroupPermission.create(:system_permission_type_id => show.id, :user_group_id => superuser.id)

puts "Initializing Primary List"
PrimaryList.create :name => "Primary List", :status => true

puts "Initializing List to Super User Group"
GroupList.create(:tag_id => superuser.id, :list_header_id => PrimaryList.first.id)

puts "Initializing Geoff Koo"
Person.create(
  :custom_id => "89567",
  :first_name => "Geoff",
  :family_name => "Koo",
  :preferred_name => "Geoff"
)