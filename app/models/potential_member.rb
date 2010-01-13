class PotentialMember < ActiveRecord::Base

  validates_presence_of :first_name, :family_name, :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-zA-Z]{2,})$/

  private
  def self.generate_key
    letters = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    key = ""
    28.times {key+=letters[rand(letters.length)]}
    key
  end
  
end
