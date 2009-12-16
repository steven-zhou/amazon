class Website < Contact
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

   def website_type
    @website_type = Array.new
    @var = TagType.find(self.contact_meta_type_id)
    @website_type <<  @var unless @var.to_be_removed
    return @website_type
  end

  private

  def update_priority
    #self.move_to_bottom
    self.priority_number = self.contactable.websites.length+1 if self.new_record?
  end

  def update_priority_before_destroy
    priority_number = self.priority_number
    Website.transaction do
      self.contactable.websites.each { |website|
        if (website.priority_number > priority_number)
          website.priority_number -= 1
          website.save!
        end
      }
    end
  end
end
