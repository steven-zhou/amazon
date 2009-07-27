class Website < Contact
acts_as_list :column => "priority_number"

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



  # Return the address of the email
  # Convenience method to access value
  def address
    read_attribute(:value)
  end

  private

  def update_priority
    self.move_to_bottom
  end

  def update_priority_before_destroy
    self.remove_from_list
  end
end
