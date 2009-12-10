class InstantMessaging < Contact
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

  before_save :update_priority
  before_destroy :update_priority_before_destroy

   #--
  ################
  #  Methods
  ################
  #++

  validates_presence_of :value

  # Return the address of the email
  # Convenience method to access value
  def address
    read_attribute(:value)
  end

 def instant_messaging_type
    @instant_messaging_type = Array.new
    @instant_messaging_type <<  TagType.find(self.contact_meta_type_id)
    return @instant_messaging_type
  end

    private

  def update_priority
    #self.move_to_bottom
    self.priority_number = self.contactable.instant_messagings.length+1 if self.new_record?
  end

  def update_priority_before_destroy
    priority_number = self.priority_number
    InstantMessaging.transaction do
      self.contactable.instant_messagings.each { |instant_messaging|
        if (instant_messaging.priority_number > priority_number)
          instant_messaging.priority_number -= 1
          instant_messaging.save!
        end
      }
    end
  end
end
