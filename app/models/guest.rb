class Guest < ActiveRecord::Base

    attr_accessor :password
  validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of  :email, :first_name,:family_name,  :phone_num
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  validates_length_of :password, :within => 6..30
  validates_format_of :password, :with => /^[A-Za-z0-9!@$%^&*()#]+$/i


  default_scope :order => "id ASC"

  #--comment----for check the guest input user_name and password is correct----

  def self.authenticate(email, password)
    guest = Guest.find(:first, :conditions => ['email = ?', email])
    if guest.nil?
      raise "Username or password invalid"
    elsif Digest::SHA256.hexdigest(password + guest.password_salt) != guest.password_hash
      raise "Username or password invalid"
    else
      return true
    end
  end

   #--comment----for the user type password , this is password setter----


  def password=(pass)
    @password=pass
    if (!self.password_salt.nil? && !self.password_hash.nil?)
      self.password_last_salt = self.password_salt
      self.password_last_hash = self.password_hash
    end
    #    self.password_updated_at = Time.now()
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash = salt, Digest::SHA256.hexdigest(@password + salt)
  end

  #--comment----for system generate random password for the guest randomly----

  def self.generate_password(length=6)
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'
    password = ''
    length.times { |i| password << chars[rand(chars.length)] }
    password
  end

end
