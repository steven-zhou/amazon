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
  has_many :contacts, :as => :contactable
  has_many :phones, :as => :contactable
  has_many :faxes, :as => :contactable
  has_many :emails, :as => :contactable
  has_many :websites, :as => :contactable
  has_many :master_docs, :as=> :entity, :order => "priority_number ASC"
  has_many :keyword_links, :as => :taggable
  has_many :keywords, :through => :keyword_links,:uniq => true
  has_many :notes, :as => :noteable

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
  accepts_nested_attributes_for :phones, :emails, :faxes, :websites,  :reject_if => proc { |attributes| attributes['value'].blank? || attributes['contact_type_id'].blank? }


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

  def primary_email
    @primary_email ||= self.emails.select {|email| email.priority_number == 1}.first
  end

  def primary_fax
    @primary_fax ||= self.faxes.select {|fax| fax.priority_number == 1}.first
  end

  def primary_website
    @primary_website ||= self.websites.select {|website| website.priority_number == 1}.first
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

end
