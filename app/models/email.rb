class Email < Contact
  #acts_as_list :column => "priority_number"

  #--
  ################
  #  Associations
  ################
  #++

  belongs_to :person
  #  belongs_to :contactmetatype

  #--
  ################
  #  Callbacks
  ################
  #++
  validates_presence_of :value
  validates_format_of :value, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  #  validates :only_one_personal_email
  before_save :update_priority
  before_destroy :update_priority_before_destroy
  #--
  ################
  #  Methods
  ################
  #++



  # Return the address of the email
  # Convenience method to access value 
  def address 
    read_attribute(:value)
  end
  def email_type
    @email_type = Array.new
    @email_type <<  TagType.find(self.contact_meta_type_id)
    return @email_type
  end
  private

  #  def self.only_one_personal_email(person_id)
  #    @p = Person.find(person_id)
  #    @p.emails.each do |i|
  #      if  i.contact_meta_type_id == 2
  #        i.contactable_type != "Person"
  #      end
  #    end
  #  end

  #  def only_one_personal_email
  #  Email.find(:all, :conditions => ["contact_meta_type_id = ?", TagType.find_by_name("Personal").id])
  #  end

  
  def update_priority
    #self.move_to_bottom
    self.priority_number = self.contactable.emails.length + 1 if self.new_record?
  end

  def update_priority_before_destroy
    priority_number = self.priority_number
    Email.transaction do
      self.contactable.emails.each { |email|
        if (email.priority_number > priority_number)
          email.priority_number -= 1
          email.save!
        end
      }
    end
  end
end
