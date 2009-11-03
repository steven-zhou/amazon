require 'digest/sha2'
class ClientSetup < ActiveRecord::Base

  belongs_to :client_organisation, :class_name => "Organisation", :foreign_key => "organisation_id"
  belongs_to :security_question_1, :class_name => "SecurityQuestion", :foreign_key => "security_question1_id"
  belongs_to :security_question_2, :class_name => "SecurityQuestion", :foreign_key => "security_question2_id"
  belongs_to :security_question_3, :class_name => "SecurityQuestion", :foreign_key => "security_question3_id"

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
end
