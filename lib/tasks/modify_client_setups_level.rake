namespace :db do
  desc "Add Default Level Labels"
  task :modify_client_setups_level => :environment do
    puts "Run Patch all default level labels ..."
    
    ClientSetup.first.update_attributes(
      :level_0_default_label => "level_0",
      :level_1_default_label => "level_1",
      :level_2_default_label => "level_2",
      :level_3_default_label => "level_3",
      :level_4_default_label => "level_4",
      :level_5_default_label => "level_5",
      :level_6_default_label => "level_6",
      :level_7_default_label => "level_7",
      :level_8_default_label => "level_8",
      :level_9_default_label => "level_9",
      :level_3_label => "level_3",
      :level_4_label => "level_4",
      :level_5_label => "level_5",
      :level_6_label => "level_6",
      :level_7_label => "level_7",
      :level_8_label => "level_8",
      :level_9_label => "level_9",

      :level_0_client_default_label => "client_organisation_level_0",
      :level_1_client_default_label => "client_organisation_level_1",
      :level_2_client_default_label => "client_organisation_level_2",
      :level_3_client_default_label => "client_organisation_level_3",
      :level_4_client_default_label => "client_organisation_level_4",
      :level_5_client_default_label => "client_organisation_level_5",
      :level_6_client_default_label => "client_organisation_level_6",
      :level_7_client_default_label => "client_organisation_level_7",
      :level_8_client_default_label => "client_organisation_level_8",
      :level_9_client_default_label => "client_organisation_level_9",

      :level_0_client_label => "client_organisation_level_0",
      :level_1_client_label => "client_organisation_level_1",
      :level_2_client_label => "client_organisation_level_2",
      :level_3_client_label => "client_organisation_level_3",
      :level_4_client_label => "client_organisation_level_4",
      :level_5_client_label => "client_organisation_level_5",
      :level_6_client_label => "client_organisation_level_6",
      :level_7_client_label => "client_organisation_level_7",
      :level_8_client_label => "client_organisation_level_8",
      :level_9_client_label => "client_organisation_level_9"


      )
       puts "DONE"

  end
end
