class Person < ActiveRecord::Base

  #--
  ################
  #  Associations
  ################
  #++

  has_many :addresses, :as => :addressable  
  has_many :phones, :as => :contactable
  has_many :emails, :as => :contactable
  has_many :contacts, :as => :contactable
  has_many :master_docs, :as=> :entity
  has_many :keyword_links, :as => :taggable
  has_many :keywords, :through => :keyword_links,:uniq => true
  has_many :person_roles
  has_many :roles, :through => :person_roles, :uniq => true

  has_many :notes, :as => :noteable

  has_one :image, :as => :imageable
    
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
  
  belongs_to :title
  belongs_to :second_title, :class_name => "Title"
  belongs_to :religion
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
  accepts_nested_attributes_for :phones, :emails,  :reject_if => proc { |attributes| attributes['value'].blank? || attributes['contact_type_id'].blank? }

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


  MARITAL_STATUS = [["Single", "Single"], ["Married", "Married"], ["Divorced", "Divorced"]]
  GENDER = [["Male", "Male"], ["Female", "Female"]]
  
  # Return the first title
  delegate :name, :to => :title, :prefix => true,:allow_nil => true
  # Return the second title
  delegate :name, :to => :second_title, :prefix => true,:allow_nil => true
  
#  named_scope :with_phone, lambda { |*args| {:include => :contacts,:conditions =>["contacts.value LIKE ? AND contacts.type = 'Phone'", args.first+'%'] } }
  named_scope :with_email, lambda { |*args| {:include => :contacts,:conditions =>["contacts.value LIKE ? AND contacts.type = 'Email'", args.first+'%'] } }
  named_scope :with_keyword, lambda { |*args| {:include => :keyword_links,:conditions =>["keyword_links.keyword_id = ?", args.first] } }

  named_scope :with_phone, lambda { |*args| {:include => :contacts,:conditions =>["contacts.pre_value LIKE ? && contacts.value LIKE ? && contacts.post_value LIKE ? AND contacts.type = 'Phone'", args.first+'%', args[1]+'%', args[2]+'%'] } }

  named_scope :with_note, lambda {|*args|{:include => :notes, :conditions => ["  notes.label LIKE ? || notes.short_description LIKE ? ",  '%'+args[0]+'%', '%'+args[1]+'%' ]}}

  def primary_address
    
    @primary_address = self.addresses.select {|address| address.priority == true}.first
  end

  def primary_phone
#    @primary_phone =  self.phones.find_by_priority(true)
    @primary_phone ||= self.phones.select {|phone| phone.priority == true}.first

  end

  # Returns the primary email or nil if not found
  def primary_email
#    @primary_email =  self.emails.find_by_priority(true)
    @primary_email ||= self.emails.select {|email| email.priority == true}.first
  end


  def other_phones

    @other_phones = self.phones.find_all_by_priority(false)

  end

  def other_emails
    @other_emails = self.emails.find_all_by_priority(false)


  end

  def other_address

    @other_addresses = self.addresses.find_all_by_priority(false)

  end

  def sorted_notes
    @sorted_notes = self.notes.find(:all, :include => [:note_type], :order => 'note_types.name DESC, notes.created_at DESC')
  end

#
  #
  #
  #
  #
  #
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
      self.primary_salutation = "#{self.title_name} #{self.first_name} #{self.family_name}".squeeze(" ").strip
    end
  end

end
