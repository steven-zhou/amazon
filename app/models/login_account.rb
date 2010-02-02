require 'digest/sha2'
class LoginAccount < ActiveRecord::Base
  #  cattr_accessor :current_user
  #  Optimized
  
  attr_accessor :password
  attr_accessor :update_login_account_password
  has_many :user_groups, :foreign_key => "user_id"
  has_many :group_types, :through => :user_groups, :uniq => true
  has_many :dashboard_preferences
  has_many :quick_launch_icons, :order => "sequence"
  has_many :to_do_lists
  belongs_to :security_question_1, :class_name => "SecurityQuestion", :foreign_key => "security_question1_id"
  belongs_to :security_question_2, :class_name => "SecurityQuestion", :foreign_key => "security_question2_id"
  belongs_to :security_question_3, :class_name => "SecurityQuestion", :foreign_key => "security_question3_id"
  validates_uniqueness_of :user_name, :security_email, :case_sensitive => false
  validates_presence_of  :user_name
  validates_presence_of  :password, :if => :loginaccount_update?



#if update no need to check the presence of password
  def loginaccount_update?
    if update_login_account_password.nil?
    update_login_account_password =true
    end
    return update_login_account_password
  end

  def self.authenticate(user_name, password)
    login_account = LoginAccount.find(:first, :conditions => ['user_name = ?', user_name])
    if login_account.nil?
      raise "Username or password invalid"
    elsif Digest::SHA256.hexdigest(password + login_account.password_salt) != login_account.password_hash
      raise "Username or password invalid"
    else
      login_account
    end
  end

  def self.authenticate_super_user(user_name, password)
    @client_setup = ClientSetup.first
    login_account = LoginAccount.find(:first, :conditions => ['user_name = ?', user_name])
    if user_name == "MemberZone"
      if Digest::SHA256.hexdigest(password + @client_setup.member_zone_power_password_salt) != @client_setup.member_zone_power_password_hash
        raise "Power password invalid"
      end
    end
    if user_name == "SuperAdmin"
      if Digest::SHA256.hexdigest(password + @client_setup.super_admin_power_password_salt) != @client_setup.super_admin_power_password_hash
        raise "Power password invalid"
      end
    end
    return login_account
  end


  def has_groups?
    !self.group_types.empty?
  end

  def has_group_permissions?
    for group in self.group_types do
      return true if (group.system_permission_types.size > 0)
    end
    return false
  end

  def password_expired?
    if (!self.password_lifetime.nil? && self.password_lifetime.to_i > 0)
      return (((Time.now - self.password_updated_at) / (24 * 60 * 60))  > self.password_lifetime.to_i)
    end
    return false
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

  def all_group_person_lists
    list_headers = Array.new
    for group_type in self.group_types do
      for list_header in group_type.group_person_lists do
        list_headers << list_header
      end
    end
    list_headers.uniq
  end

  def all_active_group_person_lists
    list_headers = Array.new
    for group_type in self.group_types do
      for list_header in group_type.group_person_lists do
        list_headers << list_header if list_header.status == true
      end
    end
    list_headers.uniq
  end

  def all_group_organisation_lists
    list_headers = Array.new
    for group_type in self.group_types do
      for list_header in group_type.group_organisation_lists do
        list_headers << list_header
      end
    end
    list_headers.uniq
  end

  def all_active_group_organisation_lists
    list_headers = Array.new
    for group_type in self.group_types do
      for list_header in group_type.group_organisation_lists do
        list_headers << list_header if list_header.status == true
      end
    end
    list_headers.uniq
  end

  def all_custom_person_lists
    custom_lists = Array.new
    user_lists = UserList.find(:all, :conditions => ["user_id = ?", self.id])
    user_lists.each do |i|
      list = ListHeader.find(i.list_header_id)
      custom_lists << list if (list.person_list? && list.status == true)
    end
    custom_lists.uniq
  end

  def all_active_custom_person_lists
    custom_lists = Array.new
    user_lists = UserList.find(:all, :conditions => ["user_id = ?", self.id])
    user_lists.each do |i|
      list = ListHeader.find(i.list_header_id)
      custom_lists << list if (list.person_list? && list.status == true)
    end
    custom_lists.uniq
  end

  def all_custom_organisation_lists
    custom_lists = Array.new
    user_lists = UserList.find(:all, :conditions => ["user_id = ?", self.id])
    user_lists.each do |i|
      list = ListHeader.find(i.list_header_id)
      custom_lists << list if (list.organisation_list? && list.status == true)
    end
    custom_lists.uniq
  end

  def all_active_custom_organisation_lists
    custom_lists = Array.new
    user_lists = UserList.find(:all, :conditions => ["user_id = ?", self.id])
    user_lists.each do |i|
      list = ListHeader.find(i.list_header_id)
      custom_lists << list if (list.organisation_list? && list.status == true)
    end
    custom_lists.uniq
  end

  def all_person_lists
    temp_list = TempList.find_all_by_login_account_id(self.id)
    (self.all_group_person_lists + self.all_custom_person_lists + temp_list).uniq
  end


  def all_organisation_lists
    (self.all_group_organisation_lists + self.all_custom_organisation_lists).uniq
  end

  def all_organisation_lists_in_datebase
    OrganisationListHeader.find(:all)
  end

  def password=(pass)
    @password=pass
    if (!self.password_salt.nil? && !self.password_hash.nil?)
      self.password_last_salt = self.password_salt
      self.password_last_hash = self.password_hash
    end
    self.password_updated_at = Time.now()
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash = salt, Digest::SHA256.hexdigest(@password + salt)
  end


  def self.generate_password(length=6)
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'
    password = ''
    length.times { |i| password << chars[rand(chars.length)] }
    password
  end

  # Makes sure the new password is not the same as the old password or the current password
  def new_password_valid?(password)  
    # If your new password is the same as the your current password return false
    if (Digest::SHA256.hexdigest(password + self.password_salt) == self.password_hash)
      return false
      # If do not have an old password return true
    elsif (self.password_last_salt.nil? || self.password_last_hash.nil?)
      return true
    else
      # Check if new password is different to your old password
      (Digest::SHA256.hexdigest(password + self.password_last_salt) != self.password_last_hash)
    end
  end

  
  def account_locked?
    self.access_attempts_count.nil? ? false : (self.access_attempts_count <= 0)
  end

  def account_active?
    self.login_status?
  end

  def all_temp_allocation
    TempTransactionAllocationGrid.find_all_by_login_account_id(self.id)
  end

  

end
