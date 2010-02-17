puts "Initializing SystemPermission data"
mdmmt = SystemPermissionMetaMetaType.create(:name => "Person", :status => true, :to_be_removed =>false)
mdmt = SystemPermissionMetaType.create(:name => "Address_Controller", :system_permission_meta_meta_type => mdmmt, :status => true, :to_be_removed =>false)
show = SystemPermissionType.create(:name => "Address_show", :system_permission_meta_type => mdmt, :status => true, :to_be_removed =>false)
edit = SystemPermissionType.create(:name => "Address_edit", :system_permission_meta_type => mdmt, :status => true, :to_be_removed =>false)
create = SystemPermissionType.create(:name => "Address_create", :system_permission_meta_type => mdmt, :status => true, :to_be_removed =>false)
update = SystemPermissionType.create(:name => "Address_update", :system_permission_meta_type => mdmt, :status => true, :to_be_removed =>false)
destroy = SystemPermissionType.create(:name => "Address_destroy", :system_permission_meta_type => mdmt, :status => true, :to_be_removed =>false)
mdmt0 = SystemPermissionMetaType.create(:name => "Note_Controller", :system_permission_meta_meta_type => mdmmt, :status => true, :to_be_removed =>false)
show0 = SystemPermissionType.create(:name => "Note_show", :system_permission_meta_type => mdmt0, :status => true, :to_be_removed =>false)
edit0 = SystemPermissionType.create(:name => "Note_edit", :system_permission_meta_type => mdmt0, :status => true, :to_be_removed =>false)
create0 = SystemPermissionType.create(:name => "Note_create", :system_permission_meta_type => mdmt0, :status => true, :to_be_removed =>false)
update0 = SystemPermissionType.create(:name => "Note_update", :system_permission_meta_type => mdmt0, :status => true, :to_be_removed =>false)
destroy0 = SystemPermissionType.create(:name => "Note_destroy", :system_permission_meta_type => mdmt0, :status => true, :to_be_removed =>false)

mdmmt1 = SystemPermissionMetaMetaType.create(:name => "Admin", :status => true)
mdmt1 = SystemPermissionMetaType.create(:name => "group_list_controller", :system_permission_meta_meta_type => mdmmt1, :status => true, :to_be_removed =>false)
showlist1 = SystemPermissionType.create(:name => "group_list_show_list", :system_permission_meta_type => mdmt1, :status => true, :to_be_removed =>false)
create1 = SystemPermissionType.create(:name => "group_list_create", :system_permission_meta_type => mdmt1, :status => true, :to_be_removed =>false)
destroy1 = SystemPermissionType.create(:name => "group_list_destroy", :system_permission_meta_type => mdmt1, :status => true, :to_be_removed =>false)


puts "Initializing Custom Group."
custom = GroupMetaMetaType.create(:name => "Custom", :status => true, :to_be_removed =>false)
security = GroupMetaMetaType.create(:name => "Security", :status => true, :to_be_removed =>false)
mdmt = GroupMetaType.create(:name => "System Users", :group_meta_meta_type => security, :status => true, :to_be_removed =>false)
admin = GroupType.create(:name => "Admin", :group_meta_type => mdmt, :status => true, :to_be_removed =>false)

puts "Initializing Super Group."
supermetatype = GroupMetaMetaType.create(:name => "MemberZone", :status => true, :to_be_removed =>false)
supergroup = GroupMetaType.create(:name => "Power Group", :group_meta_meta_type => supermetatype, :status => true, :to_be_removed =>false)
superuser = GroupType.create(:name => "Power User", :group_meta_type => supergroup, :status => true, :to_be_removed =>false)


#puts "Initializing Member Zone Super User"
#memberzone = MemberZone.create(
#  :user_name => "MemberZone",
#  :security_email => "memberzone@memberzone.com.au",
#  :password => "3Jumentos4u2",
#  :access_attempts_count => 99,
#  :session_timeout => 999999,
#  :authentication_grace_period => 9,
#  :password_by_admin => false,
#  :password_lifetime => 365,
#  :login_status => true
#)

puts "Initializing Super Admin"
superadmin = SuperAdmin.create(
  :user_name => "SuperAdmin",
  :security_email => "superadmin@memberzone.com.au",
  :password => "Cavalos258",
  :access_attempts_count => 99,
  :session_timeout => 30,
  :authentication_grace_period => 9,
  :password_by_admin => false,
  :password_lifetime => 365,
  :login_status => true
)

puts "Initializing Group to Super Users."

UserGroup.create(:user_id => @memberzone.id, :group_id => superuser.id)
UserGroup.create(:user_id => superadmin.id, :group_id => superuser.id)


puts "Initializing Permission to Super User Group"
GroupPermission.create(:system_permission_type_id => show.id, :user_group_id => superuser.id)

puts "Initializing Person Primary List"
pl = PrimaryList.create :name => "Primary List", :status => true

puts "Initializing Organisation Primary List"
opl = OrganisationPrimaryList.create :name => "Organisation Primary List", :status => true

puts "Initializing Person List to Super User Group"
GroupList.create(:tag_id => superuser.id, :list_header_id => pl.id)


puts "Initializing Organisation List to Super User Group"
GroupList.create(:tag_id => superuser.id, :list_header_id => opl.id)

#following initializing must be after 'Initializing Organisation Primary List'
puts "Initializing Client Organisation and Client Setups"
client = ClientOrganisation.create :full_name => "Client Organisation", :level => '0'
ClientSetup.create :organisation_id => client.id, :feedback_to => "feedback@memberzone.com.au", :reply_from => "feedback@memberzone.com.au", :superadmin_message => "superadmin message", :level_0_label => "level_0", :level_1_label => "level_1", :level_2_label => "level_2"

#following initializing must be after 'Initializing Client Organisation and Client Setups'
puts "Initializing password for member zone user"
client_setup = ClientSetup.first
client_setup.member_zone_power_password = "098765"
client_setup.super_admin_power_password = "098765"
client_setup.save

puts "Initializing Geoff Koo"
Person.create(
  :custom_id => "89567",
  :first_name => "Geoff",
  :family_name => "Koo",
  :preferred_name => "Geoff"
)