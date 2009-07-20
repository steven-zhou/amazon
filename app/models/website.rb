class Website < Contact


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
    if self.contactable.emails.empty?
      self.priority = true
    elsif self.priority == true
      priority = self.contactable.emails.find_by_priority(true)
      priority.toggle!(:priority) unless priority.nil?
    end
  end
end
