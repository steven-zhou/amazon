require 'digest/sha2'
class LoginAccount < ActiveRecord::Base


  belongs_to :person
  validates_presence_of :person_id, :message => "You must specify which person this login account belongs to."
  validates_uniqueness_of :person_id, :message => "Another login account already exists for this person."
  validate :person_must_exist
  validates_presence_of :user_name, :message => "You must specify a username to for use with this login."
  validates_uniqueness_of :user_name, :message => "An account with that username already exists."
  validates_presence_of :password_hash

  def self.authenticate(user_name, password)
    login_account = LoginAccount.find(:first, :conditions => ['user_name = ?', user_name])
    if login_account.blank? ||
        Digest::SHA256.hexdigest(password + login_account.password_salt) != login_account.password_hash
      raise "Username or password invalid"
    end
    login_account
  end
  
  def password=(pass)
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash =
      salt, Digest::SHA256.hexdigest(pass + salt)
  end


  private

  def person_must_exist
    errors.add(:person_id, "You must specify a person that exists.") if (person_id && Person.find_by_id(person_id).nil?)
  end


end
