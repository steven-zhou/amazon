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
  has_many :person_roles
  has_many :roles, :through => :person_roles, :uniq => true

  has_many :notes, :as => :noteable
  has_one :image, :as => :imageable

  belongs_to :primary_title, :class_name => "Title", :foreign_key => "primary_title_id"
  belongs_to :second_title, :class_name => "Title", :foreign_key => "second_title_id"
  belongs_to :marital_status, :class_name => "MaritalStatus", :foreign_key => "marital_status_id"

  has_many :people_as_source, :foreign_key => "source_person_id", :class_name => "Relationship"
  has_many :people_as_related, :foreign_key => 'related_person_id', :class_name => 'Relationship'
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
  
  has_many :fathers, :through => :people_as_source, :conditions => ['relationship_type_id = ?', ] 
  

  belongs_to :religion, :class_name => "Religion", :foreign_key => "religion_id"
  belongs_to :industry_sector, :class_name => "IndustrySector", :foreign_key => "industry_id"
  belongs_to :language
  belongs_to :other_language, :class_name => "Language", :foreign_key => "other_language_id"
  belongs_to :origin_country, :class_name => "Country", :foreign_key => "origin_country_id"
  belongs_to :residence_country, :class_name => "Country", :foreign_key => "residence_country_id"
  belongs_to :nationality, :class_name => "Country", :foreign_key => "nationality_id"


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
  
  #--
  ################
  #  Convenience
  ################
  #++
  
  # Return the first title
  delegate :name, :to => :primary_title, :prefix => true, :allow_nil => true
  # Return the second title
  delegate :name, :to => :second_title, :prefix => true, :allow_nil => true
  
  named_scope :with_email, lambda { |email_type, email_address| {:include => :contacts, :conditions =>["contacts.contact_type_id LIKE ? AND contacts.value LIKE ? AND contacts.type = 'Email'", "#{email_type}", "#{email_address}%"] } }
  named_scope :with_phone, lambda { |phone_type, phone_pre_value, phone_value, phone_post_value| {:include => :contacts,:conditions =>["contacts.contact_type_id LIKE ? && contacts.pre_value LIKE ? && contacts.value LIKE ? && contacts.post_value LIKE ? AND contacts.type = 'Phone'", "#{phone_type}", "#{phone_pre_value}%", "#{phone_value}%", "#{phone_post_value}%" ] } }
  named_scope :with_note, lambda {|note_type, note_label, note_short_description|{:include => :notes, :conditions => [" notes.note_type_id LIKE ? && notes.label LIKE ? && notes.short_description LIKE ? ", "#{note_type}", "#{note_label}%", "#{note_short_description}%" ]}}
  named_scope :with_keyword, lambda { |keyword_id| {:include => :keyword_links,:conditions =>["keyword_links.keyword_id LIKE ?", "#{keyword_id}%"] } }

  def primary_address    
    @primary_address = self.addresses.select {|address| address.first?}.first
  end

  def primary_phone
    @primary_phone ||= self.phones.select {|phone| phone.first?}.first
  end

  def primary_email
    @primary_email ||= self.emails.select {|email| email.first?}.first
  end

  def primary_fax
    @primary_fax ||= self.faxes.select {|fax| fax.first?}.first
  end

  def primary_website
    @primary_website ||= self.websites.select {|website| website.first?}.first
  end

  def primary_master_doc
    @primary_master_doc ||= self.master_docs.select {|master_doc| master_doc.first?}.first
  end


  def other_phones
    @other_phones = self.phones.select {|phone| !phone.first?}
  end

  def other_emails
    @other_emails = self.emails.select {|email| !email.first?}
  end

  def other_faxes
    @other_faxes = self.faxes.select {|fax| !fax.first?}
  end

  def other_websites
    @other_websites = self.websites.select {|website| !website.first?}
  end

  def other_addresses
    @other_addresses = self.addresses.select {|address| !address.first?}
  end

  def other_master_docs
    @other_master_docs = self.master_docs.select {|master_doc| !master_doc.first?}
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
    "#{self.title_name} #{self.first_name} #{self.family_name}".squeeze(" ").strip
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

end
