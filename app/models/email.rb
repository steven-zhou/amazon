class Email < Contact
  #acts_as_list :column => "priority_number"

  #--
  ################
  #  Associations
  ################
  #++

  belongs_to :person
  

  #--
  ################
  #  Callbacks
  ################
  #++
  validates_presence_of :value
  validates_format_of :value, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"

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

  private

  
  
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
