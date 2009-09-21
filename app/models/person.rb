class Person < ActiveRecord::Base

  #--
  ################
  #  Associations
  ################
  #++

  has_many :addresses, :as => :addressable, :order => "priority_number ASC"
  has_many :phones, :as => :contactable
  has_many :faxes, :as => :contactable
  has_many :emails, :as => :contactable
  has_many :websites, :as => :contactable
  has_many :contacts, :as => :contactable
  has_many :master_docs, :as=> :entity, :order => "priority_number ASC"
  has_many :keyword_links, :as => :taggable
  has_many :keywords, :through => :keyword_links,:uniq => true
  has_many :person_roles, :class_name => 'PersonRole', :foreign_key => 'person_id', :order => "sequence_no"
  has_many :assign_roles, :class_name => 'PersonRole', :foreign_key => 'assigned_by'
  has_many :approve_roles, :class_name => 'PersonRole', :foreign_key => 'approved_by'
  has_many :supervise_roles, :class_name => 'PersonRole', :foreign_key => 'supervised_by'
  has_many :manage_roles, :class_name => 'PersonRole', :foreign_key => 'managed_by'
  has_many :role_players, :through => :person_roles, :source => :role_player
  has_many :role_assigners, :through => :person_roles, :source => :role_assigner
  has_many :role_approvers, :through => :person_roles, :source => :role_approver
  has_many :role_supervisers, :through => :person_roles, :source => :role_superviser
  has_many :role_managers, :through => :person_roles, :source => :role_manager
  has_many :roles, :through => :person_roles, :uniq => true
  has_many :employments, :class_name => 'Employment', :foreign_key => 'person_id', :order => "sequence_no"
  has_many :emp_recruitments, :class_name => 'Employment', :foreign_key => 'hired_by'
  has_many :emp_supervisions, :class_name => 'Employment', :foreign_key => 'report_to'
  has_many :emp_terminations, :class_name => 'Employment', :foreign_key => 'terminated_by'
  has_many :emp_suspensions, :class_name => 'Employment', :foreign_key => 'suspended_by'
  has_many :emp_recruiters, :through => :employments, :source => :emp_recruiter
  has_many :emp_supervisors, :through => :employments, :source => :emp_supervisor
  has_many :emp_terminators, :through => :employments, :source => :emp_terminator
  has_many :emp_suspenders, :through => :employments, :source => :emp_suspender
  has_many :employers, :through => :employments, :source => :organisation
  has_many :organisation_key_personnels
  has_many :notes, :as => :noteable
  has_one :image, :as => :imageable
  has_many :fathers, :through => :people_as_source, :conditions => ['relationship_type_id = ?', ]
  has_many :people_as_source, :foreign_key => "source_person_id", :class_name => "Relationship"
  has_many :people_as_related, :foreign_key => 'related_person_id', :class_name => 'Relationship'
  has_many :groups, :class_name =>'Group', :foreign_key => 'group_owner'
  has_many :source_people,  :through => :people_as_related do 
    def of_type(type)
      find(:all, :conditions => ['relationship_type_id=?',RelationshipType.find_by_name(type)])
    end
  end
  has_many :related_people, :through => :people_as_source do    
    def of_type(type)
      find(:all, :conditions => ['relationship_type_id=?',RelationshipType.find_by_name(type)])
    end
  end

  
  has_many :login_accounts
  has_many :list_details
  has_many :list_headers, :through => :list_details,:uniq => true
  #has_many :players, :through => :list_details, :source => :player

  
  belongs_to :primary_title, :class_name => "Title", :foreign_key => "primary_title_id"
  belongs_to :second_title, :class_name => "Title", :foreign_key => "second_title_id"
  belongs_to :marital_status, :class_name => "MaritalStatus", :foreign_key => "marital_status_id"
  belongs_to :religion, :class_name => "Religion", :foreign_key => "religion_id"
  belongs_to :industry_sector, :class_name => "IndustrySector", :foreign_key => "industry_id"
  belongs_to :language, :class_name => "Language", :foreign_key => "language_id"
  belongs_to :other_language, :class_name => "Language", :foreign_key => "other_language_id"
  belongs_to :origin_country, :class_name => "Country", :foreign_key => "origin_country_id"
  belongs_to :residence_country, :class_name => "Country", :foreign_key => "residence_country_id"
  belongs_to :nationality, :class_name => "Country", :foreign_key => "nationality_id"
  belongs_to :gender, :class_name => "Gender", :foreign_key => "gender_id"
  


  #--
  ################
  #  Validations
  ################
  #++

  validates_presence_of :family_name
  
  #--
  ################
  #  Nested
  ################
  #++

  accepts_nested_attributes_for :addresses,
    :reject_if => proc {
    |attributes|
    blank = true
    attributes.each do |key,value|
      unless value.blank?
        if (key != 'address_type_id' && key != 'priority')
          blank = false
        end
      end
    end
    blank
  }
  accepts_nested_attributes_for :phones, :emails, :faxes, :websites,  :reject_if => proc { |attributes| attributes['value'].blank? || attributes['contact_type_id'].blank? }

  #--
  ################
  #  Callbacks
  ################
  #++

  before_save :insert_primary_salutation
  after_create :update_primary_list
  #--
  ################
  #  Convenience
  ################
  #++
  
  # Return the first title
  delegate :name, :to => :primary_title, :prefix => true, :allow_nil => true
  # Return the second title
  delegate :name, :to => :second_title, :prefix => true, :allow_nil => true
  
  def primary_address    
    @primary_address = self.addresses.select {|address| address.priority_number == 1}.first
  end

  def primary_phone
    @primary_phone ||= self.phones.select {|phone| phone.priority_number == 1}.first
  end

  def primary_email
    @primary_email ||= self.emails.select {|email| email.priority_number == 1}.first
  end

  def primary_fax
    @primary_fax ||= self.faxes.select {|fax| fax.priority_number == 1}.first
  end

  def primary_website
    @primary_website ||= self.websites.select {|website| website.priority_number == 1}.first
  end

  def primary_master_doc
    @primary_master_doc ||= self.master_docs.select {|master_doc| master_doc.priority_number == 1}.first
  end

  def primary_employment
    @primary_employment ||= self.employments.select {|employment| employment.sequence_no == 1}.first
  end

  def other_phones
    @other_phones = self.phones.select {|phone| phone.priority_number != 1}
  end

  def other_emails
    @other_emails = self.emails.select {|email| email.priority_number != 1}
  end

  def other_faxes
    @other_faxes = self.faxes.select {|fax| fax.priority_number != 1}
  end

  def other_websites
    @other_websites = self.websites.select {|website| website.priority_number != 1}
  end

  def other_addresses
    @other_addresses = self.addresses.select {|address| address.priority_number != 1}
  end

  def other_master_docs
    @other_master_docs = self.master_docs.select {|master_doc| master_doc.priority_number != 1}
  end

  def other_employments
    @other_employments = self.other_employments.select {|employment| employment.sequence_no != 1}
  end
  
  def sorted_notes
    @sorted_notes = self.notes.find(:all, :include => [:note_type])
    # @sorted_notes = self.notes.find(:all, :include => [:note_type], :order => 'note_types.name DESC, notes.created_at DESC')
  end


  #
  # Returns the first and family name
  def name
    "#{self.first_name} #{self.family_name}".squeeze(" ").strip
  end
  
  # Returns the full name and title
  def full_name_and_title
    result = String.new
    result += "#{self.primary_title.name} " unless self.primary_title.nil?
    result += "#{self.first_name} #{self.family_name}".squeeze(" ").strip
  end

  # Return the age base on birthday
  def age
    return if self.birth_date.nil?
    year_diff = Date.today.year - self.birth_date.year
    month_diff = Date.today.month - self.birth_date.month
    day_diff = Date.today.day - self.birth_date.day
    if (day_diff < 0 || month_diff < 0)
      year_diff = year_diff - 1;
    end
    return year_diff
  end

  #--
  ###################
  #  Private Methods
  ###################
  #++

  def siblings
    parents = self.related_people.find(:all, :conditions => {'relationships.relationship_type_id' => [RelationshipType.find_by_name('Father'),RelationshipType.find_by_name('Mother')]})
    siblings = parents.collect{|parent| parent.source_people.of_type('Father').concat(parent.source_people.of_type('Mother'))}.flatten.uniq
    siblings.delete(self)
    return siblings
  end
  
  #--
  ###################
  #  Private Methods
  ###################
  #++

  private
  
  # Inserts the formal salutation if blank
  # Default salutation is Title FirstName FamilyName
  def insert_primary_salutation
    if self.primary_salutation.blank?
      result = String.new
      result += "#{self.primary_title.name} " unless self.primary_title.nil?
      result += "#{self.first_name} #{self.family_name}"
      self.primary_salutation = result.squeeze(" ").strip
    end
  end

  def update_primary_list
    @list_detail = ListDetail.new(:list_header_id => PrimaryList.first.id, :person_id => self.id)
    @list_detail.save
  end

end
