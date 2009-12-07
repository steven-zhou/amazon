class Organisation < ActiveRecord::Base

  #--
  ################
  #  Associations
  ################
  #++
  has_many :organisation_key_personnels
  has_many :key_people, :through => :organisation_key_personnels, :source => :person
  has_many :employments
  has_many :employees, :through => :employments, :source => :employee
  has_many :addresses, :as => :addressable, :order => "priority_number ASC"
  has_one :image, :as => :imageable
  has_many :contacts, :as => :contactable, :order => "priority_number ASC"
  has_many :phones, :as => :contactable, :order => "priority_number ASC"
  has_many :faxes, :as => :contactable, :order => "priority_number ASC"
  has_many :emails, :as => :contactable, :order => "priority_number ASC"
  has_many :websites, :as => :contactable, :order => "priority_number ASC"
  has_many :master_docs, :as=> :entity, :order => "priority_number ASC"
  has_many :keyword_links, :as => :taggable
  has_many :keywords, :through => :keyword_links,:uniq => true
  has_many :notes, :as => :noteable
  has_many :organisation_groups, :class_name =>'OrganisationGroup', :foreign_key => 'organisation_id'
  has_many :group_types, :through => :organisation_groups
  has_many :extention_allocations, :as => :extention , :class_name => 'TransactionAllocation', :foreign_key => 'extention_id', :dependent => :destroy
  has_many :cluster_allocations, :as => :cluster ,:class_name => 'TransactionAllocation', :foreign_key => 'cluster_id', :dependent => :destroy
  has_many :organisation_bank_accounts, :foreign_key => "entity_id"
  has_many :transaction_headers, :as => :entity


  belongs_to :country, :foreign_key => :registered_country_id
  belongs_to :organisation_hierarchy
  belongs_to :organisation_type
  belongs_to :business_type
  belongs_to :business_category
  belongs_to :industry_sector
    
  #--
  ################
  #  Validations
  ################
  #++
  validates_presence_of :full_name


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
  accepts_nested_attributes_for :phones, :emails, :faxes, :websites,  :reject_if => proc { |attributes| attributes['value'].blank? || attributes['contact_meta_type_id'].blank? }

  accepts_nested_attributes_for :organisation_groups, :reject_if => proc { |attributes| attributes['organisation_group_id'].blank? }
  accepts_nested_attributes_for :organisation_bank_accounts
  #--
  ################
  #  Call back
  ################
  #++

  before_save :insert_duplication_value
  #--
  ################
  #  Convenience
  ################
  #++


  def primary_address
    @primary_address = self.addresses.select {|address| address.priority_number == 1}.first
  end


  def primary_phone
    @primary_phone ||= self.phones.select {|phone| phone.priority_number == 1}.first
  end

  def secondary_phone
    @secondary_phone ||= self.phones.select {|phone| phone.priority_number == 2}.first
  end

  def primary_email
    @primary_email ||= self.emails.select {|email| email.priority_number == 1}.first
  end

  def secondary_email
    @secondary_email ||= self.emails.select {|email| email.priority_number == 2}.first
  end

  def primary_fax
    @primary_fax ||= self.faxes.select {|fax| fax.priority_number == 1}.first
  end

  def primary_website
    @primary_website ||= self.websites.select {|website| website.priority_number == 1}.first
  end
  def secondary_website
    @secondary_website ||= self.websites.select {|website| website.priority_number == 2}.first
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

  def sorted_notes
    @sorted_notes = self.notes.find(:all, :include => [:note_type])
    # @sorted_notes = self.notes.find(:all, :include => [:note_type], :order => 'note_types.name DESC, notes.created_at DESC')
  end

  def personal_email_types
    @personal_email_types = Array.new
    self.emails.each do |email|
      @personal_email_types <<  TagType.find(email.contact_meta_type_id)
    end
    return @personal_email_types
  end

  def personal_phone_types
    @personal_phone_types = Array.new
    self.phones.each do |phone|
      @personal_phone_types <<  TagType.find(phone.contact_meta_type_id)
    end

    return @personal_phone_types
  end

  def personal_website_types
    @personal_website_types = Array.new
    self.websites.each do |website|
      @personal_website_types <<  TagType.find(website.contact_meta_type_id)
    end

  end

  def personal_address_types
    @personal_address_types = Array.new
    self.addresses.each do |address|
      @personal_address_types <<  AmazonSetting.find(address.address_type_id)
    end

    return @personal_address_types
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

  def insert_duplication_value
    @organisational_duplication_formula = OrganisationalDuplicationFormula.applied_setting
    unless @organisational_duplication_formula.nil?
      self.duplication_value = ""
      @organisational_duplication_formula.duplication_formula_details.each do |i|
        if i.is_foreign_key
          self.duplication_value += self.__send__(i.field_name.to_sym).name[0, i.number_of_charecter] unless self.__send__(i.field_name.to_sym).nil?
        else
          self.duplication_value += self.__send__(i.field_name.to_sym)[0, i.number_of_charecter] unless self.__send__(i.field_name.to_sym).nil?
        end
      end
    end
  end

end
