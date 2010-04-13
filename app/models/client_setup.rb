require 'digest/sha2'
class ClientSetup < ActiveRecord::Base

  belongs_to :client_organisation, :class_name => "Organisation", :foreign_key => "organisation_id"
  belongs_to :security_question_1, :class_name => "SecurityQuestion", :foreign_key => "security_question1_id"
  belongs_to :security_question_2, :class_name => "SecurityQuestion", :foreign_key => "security_question2_id"
  belongs_to :security_question_3, :class_name => "SecurityQuestion", :foreign_key => "security_question3_id"
  belongs_to :home_country, :class_name => "Country",:foreign_key => "home_country_id"


  def check_primary_password(password)
    Digest::SHA256.hexdigest(password + self.primary_password_salt) == self.primary_password_hash
  end

  def check_secondary_password(password)
    Digest::SHA256.hexdigest(password + self.secondary_password_salt) == self.secondary_password_hash
  end

  def member_zone_power_password=(pass)
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.member_zone_power_password_salt, self.member_zone_power_password_hash =
      salt, Digest::SHA256.hexdigest(pass + salt)
  end

  def super_admin_power_password=(pass)
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.super_admin_power_password_salt, self.super_admin_power_password_hash =
      salt, Digest::SHA256.hexdigest(pass + salt)
  end


  def self.label_0
    ClientSetup.first.level_0_label.blank? ? ClientSetup.first.level_0_default_label : ClientSetup.first.level_0_label
  end

  def self.label_1
    ClientSetup.first.level_1_label.blank? ? ClientSetup.first.level_1_default_label : ClientSetup.first.level_1_label
  end

  def self.label_2
    ClientSetup.first.level_2_label.blank? ? ClientSetup.first.level_2_default_label : ClientSetup.first.level_2_label
  end

  def self.label_3
    ClientSetup.first.level_3_label.blank? ? ClientSetup.first.level_3_default_label : ClientSetup.first.level_3_label
  end

  def self.label_4
    ClientSetup.first.level_4_label.blank? ? ClientSetup.first.level_4_default_label : ClientSetup.first.level_4_label
  end

  def self.label_5
    ClientSetup.first.level_5_label.blank? ? ClientSetup.first.level_5_default_label : ClientSetup.first.level_5_label
  end

  def self.label_6
    ClientSetup.first.level_6_label.blank? ? ClientSetup.first.level_6_default_label : ClientSetup.first.level_6_label
  end

  def self.label_7
    ClientSetup.first.level_7_label.blank? ? ClientSetup.first.level_7_default_label : ClientSetup.first.level_7_label
  end

  def self.label_8
    ClientSetup.first.level_8_label.blank? ? ClientSetup.first.level_8_default_label : ClientSetup.first.level_8_label
  end

  def self.label_9
    ClientSetup.first.level_9_label.blank? ? ClientSetup.first.level_9_default_label : ClientSetup.first.level_9_label
  end

  def self.client_label_0
    ClientSetup.first.level_0_client_label.blank? ? ClientSetup.first.level_0_client_default_label : ClientSetup.first.level_0_client_label
  end

  def self.client_label_1
    ClientSetup.first.level_1_client_label.blank? ? ClientSetup.first.level_1_client_default_label : ClientSetup.first.level_1_client_label
  end

  def self.client_label_2
    ClientSetup.first.level_2_client_label.blank? ? ClientSetup.first.level_2_client_default_label : ClientSetup.first.level_2_client_label
  end

  def self.client_label_3
    ClientSetup.first.level_3_client_label.blank? ? ClientSetup.first.level_3_client_default_label : ClientSetup.first.level_3_client_label
  end

  def self.client_label_4
    ClientSetup.first.level_4_client_label.blank? ? ClientSetup.first.level_4_client_default_label : ClientSetup.first.level_4_client_label
  end

  def self.client_label_5
    ClientSetup.first.level_5_client_label.blank? ? ClientSetup.first.level_5_client_default_label : ClientSetup.first.level_5_client_label
  end

  def self.client_label_6
    ClientSetup.first.level_6_client_label.blank? ? ClientSetup.first.level_6_client_default_label : ClientSetup.first.level_6_client_label
  end

  def self.client_label_7
    ClientSetup.first.level_7_client_label.blank? ? ClientSetup.first.level_7_client_default_label : ClientSetup.first.level_7_client_label
  end

  def self.client_label_8
    ClientSetup.first.level_8_client_label.blank? ? ClientSetup.first.level_8_client_default_label : ClientSetup.first.level_8_client_label
  end

  def self.client_label_9
    ClientSetup.first.level_9_client_label.blank? ? ClientSetup.first.level_9_client_default_label : ClientSetup.first.level_9_client_label
  end
end
