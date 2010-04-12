class Guest < ActiveRecord::Base




  validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of  :email




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

end
