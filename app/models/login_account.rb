require 'digest/sha2'
class LoginAccount < ActiveRecord::Base
  #  cattr_accessor :current_user
  attr_accessor :password
  has_many :user_groups, :foreign_key => "user_id"
  has_many :group_types, :through => :user_groups, :uniq => true

#---------------------validate------------------------------------
  validates_uniqueness_of :user_name



  def self.authenticate(user_name, password)
    login_account = LoginAccount.find(:first, :conditions => ['user_name = ?', user_name])

    if login_account.nil?
      raise "Username or password invalid"
    elsif Digest::SHA256.hexdigest(password + login_account.password_salt) != login_account.password_hash
      login_account.access_attempts_count -= 1 if login_account.access_attempts_count.to_i > 0
      login_account.save
      raise "Username or password invalid"
    else
      login_account
    end

  end


  def self.validate_group(user_id)
    login_account = LoginAccount.find(:first, :conditions => ['id = ?', user_id])
    @group_types = login_account.group_types
    if @group_types.blank?
      raise "you do not have group permission"
    end
    @group_types
  end

  def self.validate_permission(user_id)
    login_account = LoginAccount.find_by_id(user_id)
    @group_types = login_account.group_types
    @system_permission_types = Array.new
    @group_types.each do |group|
      @system_permission_types += group.system_permission_types
    end
    @system_permission_types.uniq

    if @system_permission_types.blank?
      raise "you do not have system permissions"
    end
    @system_permission_types
  end

  def self.validate_attempts_count(user_id)
    login_account = LoginAccount.find_by_id(user_id)

    @access_attempts_count = login_account.access_attempts_count
    if (@access_attempts_count.to_i <= 0)
      raise "your account has been locked, please call admin"
    end
    @access_attempts_count
  end
  
  def list_headers
    list_headers = Array.new
    for group_type in self.group_types do
      for list_header in group_type.list_headers do
        list_headers << list_header
      end
    end
    list_headers.uniq
  end

  def custom_lists
    custom_lists = Array.new
    self.user_lists.each do |i|
      custom_lists << ListHeader.find(i.list_header_id)
    end
    custom_lists.uniq
  end

  def all_lists
    temp_list = TempList.find_all_by_login_account_id(self.id)
    (self.list_headers + self.custom_lists + temp_list).uniq
  end


  def password=(pass)
    @password=pass
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash =
      salt, Digest::SHA256.hexdigest(@password + salt)
  end


  def self.generate_password(length=6)
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'
    password = ''
    length.times { |i| password << chars[rand(chars.length)] }
    password
  end

  def account_locked?
    self.access_attempts_count.nil? ? false : (self.access_attempts_count <= 0)
  end

  def user_update?
    update_password
  end

  private

  #  def   different_password_username
  #    #errors.add(:user_name, "You must specify username different with password") if (user_name && password && self.password == self.user_name?)
  #    self.password != self.user_name
  #  end

  def  answer_unique
    self.question1_answer != self.question2_answer && self.question2_answer != self.question3_answer && self.question1_answer != self.question3_answer
    
  end

  def person_must_exist
    errors.add(:person_id, "You must specify a person that exists.") if (person_id && Person.find_by_id(person_id).nil?)
  end
  #
  #  def user_update?
  #    LoginAccount.current_user.group_types.each do |group|
  #      !group.name.include?("Admin")||!group.name.include?("Super Admin")
  #    end
  #  end
  #  def user_name_exist_and_unique
  #    if (user_name.blank? || !LoginAccount.find_by_user_name(user_name).nil?)
  #        errors.add(:user_name, "You must specify a user name and should unique.")
  #    end
  #  end

end
