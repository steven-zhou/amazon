class SystemUser < LoginAccount

  belongs_to :person
  belongs_to :security_question_1, :class_name => "SecurityQuestion", :foreign_key => "security_question1_id"
  belongs_to :security_question_2, :class_name => "SecurityQuestion", :foreign_key => "security_question2_id"
  belongs_to :security_question_3, :class_name => "SecurityQuestion", :foreign_key => "security_question3_id"

#  has_many :user_groups, :foreign_key => "user_id"
#  has_many :group_types, :through => :user_groups, :uniq => true

  has_many :user_lists, :foreign_key => "user_id"
  has_many :user_list_headers, :through => :user_lists,:source => :user_list_header,  :uniq => true


   #---------------------validate------------------------------------

  #for---both---admin---user----
  validates_presence_of :person_id, :user_name, :security_email
  #:access_attempts_count, :session_timeout, :authentication_grace_period
  validates_uniqueness_of :person_id, :security_email
  validate :person_must_exist
  validates_length_of :user_name, :within => 6..30, :too_long => "pick a shorter name", :too_short => "pick a longer name"
  validates_format_of :user_name, :with => /^[A-Za-z0-9!@$%^&*()#]+$/i, :message => "regular expression of username is wrong."
  validates_format_of :security_email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"

  #--------sepcial for user

  validates_presence_of :password_hash, :if => :user_update?
  validates_presence_of :password, :if => :user_update?
  validates_length_of :password, :within => 6..30, :too_long => "pick a shorter password", :too_short => "pick a longer password", :if => :user_update?
  validates_confirmation_of :password,  :message => "password confirmation is different with password", :if => :user_update?
  validates_format_of :password, :with => /^[A-Za-z0-9!@$%^&*()#]+$/i, :message => "regular expression of password is wrong.", :if => :user_update?
  validates_presence_of :question1_answer, :message => "you must type three security questions answer.", :if => :user_update?
  validates_presence_of :question2_answer, :message => "you must type three security questions answer.", :if => :user_update?
  validates_presence_of :question3_answer, :message => "you must type three security questions answer.", :if => :user_update?

  attr_accessor :password_confirmation
  attr_accessor :update_password


  default_scope :order => "id ASC"


  def user_update?
    update_password
  end

  private

  def person_must_exist
    errors.add(:person_id, "You must specify a person that exists.") if (person_id && Person.find_by_id(person_id).nil?)
  end

  def  answer_unique
  self.question1_answer != self.question2_answer && self.question2_answer != self.question3_answer && self.question1_answer != self.question3_answer
end

end
