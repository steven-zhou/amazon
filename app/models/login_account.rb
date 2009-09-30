require 'digest/sha2'
class LoginAccount < ActiveRecord::Base


  belongs_to :person
  belongs_to :security_question, :class_name => "SecurityQuestion", :foreign_key => "security_question1_id"
  belongs_to :security_question, :class_name => "SecurityQuestion", :foreign_key => "security_question2_id"
  belongs_to :security_question, :class_name => "SecurityQuestion", :foreign_key => "security_question3_id"

  
  has_many :user_groups, :foreign_key => "user_id"
  has_many :group_types, :through => :user_groups, :uniq => true
  has_many :user_lists, :foreign_key => "user_id"

  validates_presence_of :person_id
  validates_uniqueness_of :person_id
  validate :person_must_exist
  before_save :different_password_username, :answer_unique


  validates_presence_of :user_name
  validates_uniqueness_of :user_name
  validates_length_of :user_name, :within => 6..30, :too_long => "pick a shorter name", :too_short => "pick a longer name"
  validates_format_of :user_name, :with => /^[A-Za-z0-9!@$%^&*()#]+$/i, :message => "regular expression of username is wrong."

  validates_presence_of :password_hash
  validates_presence_of :password, :message => "password can't be blank", :on => :create
  validates_length_of :password, :within => 6..30, :too_long => "pick a shorter password", :too_short => "pick a longer password", :on => :create
  validates_confirmation_of :password,  :message => "password confirmation is different with password", :on => :create

  #validates_presence_of :password_confirmation, :message => "password confirmation can not blank"
  validates_format_of :password, :with => /^[A-Za-z0-9!@$%^&*()#]+$/i, :message => "regular expression of password is wrong.", :on => :create

  validates_presence_of :security_email
  validates_format_of :security_email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  validates_uniqueness_of :security_email



  #attr_accessor :password, :password_confirmation
  attr_accessor :password, :password_confirmation




  def self.authenticate(user_name, password)
    login_account = LoginAccount.find(:first, :conditions => ['user_name = ?', user_name])
    if login_account.blank? ||
        Digest::SHA256.hexdigest(password + login_account.password_salt) != login_account.password_hash
      raise "Username or password invalid"
    end
    login_account
  end


  def self.validate_group(user_id)
    #@group_types = LoginAccount.find_by_id(user_id).group_types
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

  def password=(pass)
    @password=pass
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash =
      salt, Digest::SHA256.hexdigest(@password + salt)
  end



  private

  def   different_password_username
    #errors.add(:user_name, "You must specify username different with password") if (user_name && password && self.password == self.user_name?)
    self.password != self.user_name
  end

  def  answer_unique
    self.question1_answer != self.question2_answer && self.question2_answer != self.question3_answer && self.question1_answer != self.question3_answer
    
  end

  def person_must_exist
    errors.add(:person_id, "You must specify a person that exists.") if (person_id && Person.find_by_id(person_id).nil?)
  end


end
